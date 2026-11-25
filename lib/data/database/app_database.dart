import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'seed_data.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();
  static Database? _database;
  bool isWebFallback = kIsWeb;

  AppDatabase._init();

  Future<Database?> get database async {
    if (kIsWeb) {
      isWebFallback = true;
      return null;
    }

    if (_database != null) return _database!;
    try {
      _database = await _initDB('dayguide.db');
      return _database!;
    } catch (e) {
      debugPrint('SQLite initialization error, falling back to memory store: $e');
      isWebFallback = true;
      return null;
    }
  }

  Future<Database> _initDB(String filePath) async {
    // If running on desktop (Windows/Linux/macOS), initialize FFI
    if (!kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.windows ||
         defaultTargetPlatform == TargetPlatform.linux ||
         defaultTargetPlatform == TargetPlatform.macOS)) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // 1. CATEGORIES table
    await db.execute('''
      CREATE TABLE CATEGORIES (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        icon TEXT,
        color TEXT
      )
    ''');

    // 2. GUIDES table
    await db.execute('''
      CREATE TABLE GUIDES (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        thumbnail TEXT,
        difficulty TEXT,
        estimated_minutes INTEGER,
        source TEXT,
        created_at TEXT,
        updated_at TEXT,
        FOREIGN KEY (category_id) REFERENCES CATEGORIES (id) ON DELETE CASCADE
      )
    ''');

    // 3. GUIDE_STEPS table
    await db.execute('''
      CREATE TABLE GUIDE_STEPS (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        guide_id INTEGER NOT NULL,
        step_number INTEGER NOT NULL,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        image TEXT,
        FOREIGN KEY (guide_id) REFERENCES GUIDES (id) ON DELETE CASCADE
      )
    ''');

    // 4. BOOKMARKS table
    await db.execute('''
      CREATE TABLE BOOKMARKS (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        guide_id INTEGER NOT NULL UNIQUE,
        saved_at TEXT,
        FOREIGN KEY (guide_id) REFERENCES GUIDES (id) ON DELETE CASCADE
      )
    ''');

    // 5. READING_HISTORY table
    await db.execute('''
      CREATE TABLE READING_HISTORY (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        guide_id INTEGER NOT NULL UNIQUE,
        last_read_at TEXT,
        progress INTEGER,
        FOREIGN KEY (guide_id) REFERENCES GUIDES (id) ON DELETE CASCADE
      )
    ''');

    // Seed initial data
    await SeedData.insertInitialData(db);
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
