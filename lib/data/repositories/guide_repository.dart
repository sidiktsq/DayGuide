import 'package:sqflite/sqflite.dart';
import '../database/app_database.dart';
import '../database/seed_data.dart';
import '../models/category_model.dart';
import '../models/guide_model.dart';
import '../models/guide_step_model.dart';

class GuideRepository {
  final AppDatabase _dbProvider = AppDatabase.instance;

  // In-memory fallback data for Web / fallback mode
  static final List<Map<String, dynamic>> _memCategories =
      SeedData.getInitialCategories().map((e) => Map<String, dynamic>.from(e)).toList();
  static final List<Map<String, dynamic>> _memGuides =
      SeedData.getInitialGuides().map((e) => Map<String, dynamic>.from(e)).toList();
  static final List<Map<String, dynamic>> _memSteps =
      SeedData.getInitialSteps().map((e) => Map<String, dynamic>.from(e)).toList();
  static final List<Map<String, dynamic>> _memBookmarks =
      SeedData.getInitialBookmarks().map((e) => Map<String, dynamic>.from(e)).toList();
  static final List<Map<String, dynamic>> _memHistory =
      SeedData.getInitialHistory().map((e) => Map<String, dynamic>.from(e)).toList();

  bool get _useFallback => _dbProvider.isWebFallback;

  // Categories
  Future<List<CategoryModel>> getAllCategories() async {
    final db = await _dbProvider.database;
    if (_useFallback || db == null) {
      return _memCategories.map((m) => CategoryModel.fromMap(m)).toList();
    }

    final maps = await db.query('CATEGORIES', orderBy: 'id ASC');
    return maps.map((m) => CategoryModel.fromMap(m)).toList();
  }

  Future<CategoryModel?> getCategoryById(int id) async {
    final db = await _dbProvider.database;
    if (_useFallback || db == null) {
      final found = _memCategories.where((c) => c['id'] == id);
      return found.isNotEmpty ? CategoryModel.fromMap(found.first) : null;
    }

    final maps = await db.query(
      'CATEGORIES',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return CategoryModel.fromMap(maps.first);
    }
    return null;
  }

  // Guides
  Future<List<GuideModel>> getAllGuides({int? categoryId, String? searchQuery}) async {
    final db = await _dbProvider.database;
    if (_useFallback || db == null) {
      return _getMemGuides(categoryId: categoryId, searchQuery: searchQuery);
    }

    String query = '''
      SELECT g.*, 
             c.name as category_name, 
             c.color as category_color, 
             c.icon as category_icon,
             CASE WHEN b.id IS NOT NULL THEN 1 ELSE 0 END as is_bookmarked,
             rh.progress as read_progress
      FROM GUIDES g
      JOIN CATEGORIES c ON g.category_id = c.id
      LEFT JOIN BOOKMARKS b ON g.id = b.guide_id
      LEFT JOIN READING_HISTORY rh ON g.id = rh.guide_id
    ''';

    final List<String> conditions = [];
    final List<dynamic> args = [];

    if (categoryId != null && categoryId > 0) {
      conditions.add('g.category_id = ?');
      args.add(categoryId);
    }

    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      conditions.add('(g.title LIKE ? OR g.description LIKE ?)');
      args.add('%$searchQuery%');
      args.add('%$searchQuery%');
    }

    if (conditions.isNotEmpty) {
      query += ' WHERE ${conditions.join(' AND ')}';
    }

    query += ' ORDER BY g.id ASC';

    final results = await db.rawQuery(query, args);
    return results.map((m) {
      return GuideModel.fromMap(
        m,
        isBookmarked: (m['is_bookmarked'] as int? ?? 0) == 1,
        readProgress: m['read_progress'] as int?,
      );
    }).toList();
  }

  Future<GuideModel?> getGuideById(int id) async {
    final db = await _dbProvider.database;
    if (_useFallback || db == null) {
      final all = _getMemGuides();
      final match = all.where((g) => g.id == id);
      if (match.isEmpty) return null;
      final guide = match.first;
      final steps = _memSteps
          .where((s) => s['guide_id'] == id)
          .map((s) => GuideStepModel.fromMap(s))
          .toList()
        ..sort((a, b) => a.stepNumber.compareTo(b.stepNumber));
      return guide.copyWith(steps: steps);
    }

    final results = await db.rawQuery('''
      SELECT g.*, 
             c.name as category_name, 
             c.color as category_color, 
             c.icon as category_icon,
             CASE WHEN b.id IS NOT NULL THEN 1 ELSE 0 END as is_bookmarked,
             rh.progress as read_progress
      FROM GUIDES g
      JOIN CATEGORIES c ON g.category_id = c.id
      LEFT JOIN BOOKMARKS b ON g.id = b.guide_id
      LEFT JOIN READING_HISTORY rh ON g.id = rh.guide_id
      WHERE g.id = ?
      LIMIT 1
    ''', [id]);

    if (results.isEmpty) return null;

    final guideMap = results.first;

    // Fetch steps
    final stepMaps = await db.query(
      'GUIDE_STEPS',
      where: 'guide_id = ?',
      whereArgs: [id],
      orderBy: 'step_number ASC',
    );
    final steps = stepMaps.map((m) => GuideStepModel.fromMap(m)).toList();

    return GuideModel.fromMap(
      guideMap,
      steps: steps,
      isBookmarked: (guideMap['is_bookmarked'] as int? ?? 0) == 1,
      readProgress: guideMap['read_progress'] as int?,
    );
  }

  // Bookmarks
  Future<List<GuideModel>> getBookmarkedGuides() async {
    final db = await _dbProvider.database;
    if (_useFallback || db == null) {
      final bookmarkedIds = _memBookmarks.map((b) => b['guide_id'] as int).toSet();
      return _getMemGuides().where((g) => bookmarkedIds.contains(g.id)).map((g) {
        return g.copyWith(isBookmarked: true);
      }).toList();
    }

    final results = await db.rawQuery('''
      SELECT g.*, 
             c.name as category_name, 
             c.color as category_color, 
             c.icon as category_icon,
             1 as is_bookmarked,
             rh.progress as read_progress,
             b.saved_at
      FROM BOOKMARKS b
      JOIN GUIDES g ON b.guide_id = g.id
      JOIN CATEGORIES c ON g.category_id = c.id
      LEFT JOIN READING_HISTORY rh ON g.id = rh.guide_id
      ORDER BY b.saved_at DESC, b.id DESC
    ''');

    return results.map((m) {
      return GuideModel.fromMap(
        m,
        isBookmarked: true,
        readProgress: m['read_progress'] as int?,
      );
    }).toList();
  }

  Future<bool> isBookmarked(int guideId) async {
    final db = await _dbProvider.database;
    if (_useFallback || db == null) {
      return _memBookmarks.any((b) => b['guide_id'] == guideId);
    }

    final results = await db.query(
      'BOOKMARKS',
      where: 'guide_id = ?',
      whereArgs: [guideId],
      limit: 1,
    );
    return results.isNotEmpty;
  }

  Future<void> addBookmark(int guideId) async {
    final db = await _dbProvider.database;
    if (_useFallback || db == null) {
      _memBookmarks.removeWhere((b) => b['guide_id'] == guideId);
      _memBookmarks.insert(0, {
        'id': _memBookmarks.length + 1,
        'guide_id': guideId,
        'saved_at': DateTime.now().toIso8601String(),
      });
      return;
    }

    await db.insert(
      'BOOKMARKS',
      {
        'guide_id': guideId,
        'saved_at': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeBookmark(int guideId) async {
    final db = await _dbProvider.database;
    if (_useFallback || db == null) {
      _memBookmarks.removeWhere((b) => b['guide_id'] == guideId);
      return;
    }

    await db.delete(
      'BOOKMARKS',
      where: 'guide_id = ?',
      whereArgs: [guideId],
    );
  }

  Future<void> clearAllBookmarks() async {
    final db = await _dbProvider.database;
    if (_useFallback || db == null) {
      _memBookmarks.clear();
      return;
    }
    await db.delete('BOOKMARKS');
  }

  Future<bool> toggleBookmark(int guideId) async {
    final bookmarked = await isBookmarked(guideId);
    if (bookmarked) {
      await removeBookmark(guideId);
      return false;
    } else {
      await addBookmark(guideId);
      return true;
    }
  }

  // Reading History
  Future<List<GuideModel>> getReadingHistory() async {
    final db = await _dbProvider.database;
    if (_useFallback || db == null) {
      final historyMap = {for (var h in _memHistory) h['guide_id'] as int: h};
      final guides = _getMemGuides().where((g) => historyMap.containsKey(g.id)).toList();
      return guides.map((g) {
        final h = historyMap[g.id]!;
        return g.copyWith(readProgress: h['progress'] as int?);
      }).toList();
    }

    final results = await db.rawQuery('''
      SELECT g.*, 
             c.name as category_name, 
             c.color as category_color, 
             c.icon as category_icon,
             CASE WHEN b.id IS NOT NULL THEN 1 ELSE 0 END as is_bookmarked,
             rh.progress as read_progress,
             rh.last_read_at
      FROM READING_HISTORY rh
      JOIN GUIDES g ON rh.guide_id = g.id
      JOIN CATEGORIES c ON g.category_id = c.id
      LEFT JOIN BOOKMARKS b ON g.id = b.guide_id
      ORDER BY rh.last_read_at DESC
    ''');

    return results.map((m) {
      return GuideModel.fromMap(
        m,
        isBookmarked: (m['is_bookmarked'] as int? ?? 0) == 1,
        readProgress: m['read_progress'] as int?,
      );
    }).toList();
  }

  Future<void> updateReadingProgress(int guideId, int progress) async {
    final db = await _dbProvider.database;
    if (_useFallback || db == null) {
      _memHistory.removeWhere((h) => h['guide_id'] == guideId);
      _memHistory.insert(0, {
        'id': _memHistory.length + 1,
        'guide_id': guideId,
        'last_read_at': DateTime.now().toIso8601String(),
        'progress': progress,
      });
      return;
    }

    await db.insert(
      'READING_HISTORY',
      {
        'guide_id': guideId,
        'last_read_at': DateTime.now().toIso8601String(),
        'progress': progress,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> clearReadingHistory() async {
    final db = await _dbProvider.database;
    if (_useFallback || db == null) {
      _memHistory.clear();
      return;
    }

    await db.delete('READING_HISTORY');
  }

  Future<int> getGuideCountByCategory(int categoryId) async {
    final db = await _dbProvider.database;
    if (_useFallback || db == null) {
      return _memGuides.where((g) => g['category_id'] == categoryId).length;
    }

    final res = await db.rawQuery(
      'SELECT COUNT(*) as count FROM GUIDES WHERE category_id = ?',
      [categoryId],
    );
    return Sqflite.firstIntValue(res) ?? 0;
  }

  // Helper for in-memory guides joining category and bookmark/history data
  List<GuideModel> _getMemGuides({int? categoryId, String? searchQuery}) {
    final bookmarkedIds = _memBookmarks.map((b) => b['guide_id'] as int).toSet();
    final historyMap = {for (var h in _memHistory) h['guide_id'] as int: h['progress'] as int?};
    final catMap = {for (var c in _memCategories) c['id'] as int: c};

    var filtered = _memGuides.asMap().entries.map((entry) {
      final g = entry.value;
      final cId = g['category_id'] as int;
      final cat = catMap[cId];
      final id = g['id'] as int;
      return GuideModel.fromMap(
        {
          ...g,
          'category_name': cat?['name'],
          'category_color': cat?['color'],
          'category_icon': cat?['icon'],
        },
        isBookmarked: bookmarkedIds.contains(id),
        readProgress: historyMap[id],
      );
    }).toList();

    if (categoryId != null && categoryId > 0) {
      filtered = filtered.where((g) => g.categoryId == categoryId).toList();
    }

    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      final queryLower = searchQuery.toLowerCase();
      filtered = filtered.where((g) {
        return g.title.toLowerCase().contains(queryLower) ||
            (g.description?.toLowerCase().contains(queryLower) ?? false);
      }).toList();
    }

    return filtered;
  }
}
