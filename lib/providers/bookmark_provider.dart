import 'package:flutter/foundation.dart';
import '../data/models/guide_model.dart';
import '../data/repositories/guide_repository.dart';

class BookmarkProvider with ChangeNotifier {
  final GuideRepository _repository = GuideRepository();

  List<GuideModel> _bookmarkedGuides = [];
  bool _isLoading = false;
  String _currentFilter = 'all'; // all, unread, completed, favorite

  List<GuideModel> get bookmarkedGuides => _bookmarkedGuides;
  bool get isLoading => _isLoading;
  String get currentFilter => _currentFilter;

  List<GuideModel> get filteredGuides {
    if (_currentFilter == 'unread') {
      return _bookmarkedGuides.where((g) => (g.readProgress ?? 0) < 100).toList();
    } else if (_currentFilter == 'completed') {
      return _bookmarkedGuides.where((g) => (g.readProgress ?? 0) >= 100).toList();
    } else if (_currentFilter == 'favorite') {
      // Guide 1 and 8 as favorites
      return _bookmarkedGuides.where((g) => g.id == 1 || g.id == 8).toList();
    }
    return _bookmarkedGuides;
  }

  void setFilter(String filter) {
    _currentFilter = filter;
    notifyListeners();
  }

  Future<void> loadBookmarks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _bookmarkedGuides = await _repository.getBookmarkedGuides();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading bookmarks: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool isBookmarked(int guideId) {
    return _bookmarkedGuides.any((g) => g.id == guideId);
  }

  Future<bool> toggleBookmark(int guideId) async {
    final result = await _repository.toggleBookmark(guideId);
    await loadBookmarks();
    return result;
  }

  Future<void> removeBookmark(int guideId) async {
    await _repository.removeBookmark(guideId);
    await loadBookmarks();
  }

  Future<void> clearAll() async {
    await _repository.clearAllBookmarks();
    _bookmarkedGuides = [];
    notifyListeners();
  }
}
