import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSettingsProvider with ChangeNotifier {
  // Theme mode: light, dark, system
  String _themeMode = 'light';
  double _fontScale = 1.0;

  // Notification toggles
  bool _dailyMorningTips = true;
  bool _weeklyRecommendations = true;
  bool _readingReminders = false;

  // Offline storage
  bool _autoOfflineSave = true;
  String _cacheSize = '12.5 MB';

  String get themeMode => _themeMode;
  double get fontScale => _fontScale;
  bool get dailyMorningTips => _dailyMorningTips;
  bool get weeklyRecommendations => _weeklyRecommendations;
  bool get readingReminders => _readingReminders;
  bool get autoOfflineSave => _autoOfflineSave;
  String get cacheSize => _cacheSize;

  ThemeMode get flutterThemeMode {
    if (_themeMode == 'dark') return ThemeMode.dark;
    if (_themeMode == 'system') return ThemeMode.system;
    return ThemeMode.light;
  }

  ThemeSettingsProvider() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _themeMode = prefs.getString('settings_theme_mode') ?? 'light';
      _fontScale = prefs.getDouble('settings_font_scale') ?? 1.0;
      _dailyMorningTips = prefs.getBool('settings_daily_tips') ?? true;
      _weeklyRecommendations = prefs.getBool('settings_weekly_recs') ?? true;
      _readingReminders = prefs.getBool('settings_reading_reminders') ?? false;
      _autoOfflineSave = prefs.getBool('settings_auto_offline') ?? true;
      _cacheSize = prefs.getString('settings_cache_size') ?? '12.5 MB';
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading theme settings: $e');
    }
  }

  Future<void> setThemeMode(String mode) async {
    _themeMode = mode;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('settings_theme_mode', mode);
    } catch (e) {
      debugPrint('Error saving theme mode: $e');
    }
  }

  Future<void> increaseFontSize() async {
    if (_fontScale < 1.3) {
      _fontScale = double.parse((_fontScale + 0.1).toStringAsFixed(1));
      notifyListeners();
      _saveFontScale();
    }
  }

  Future<void> decreaseFontSize() async {
    if (_fontScale > 0.8) {
      _fontScale = double.parse((_fontScale - 0.1).toStringAsFixed(1));
      notifyListeners();
      _saveFontScale();
    }
  }

  Future<void> _saveFontScale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('settings_font_scale', _fontScale);
    } catch (e) {
      debugPrint('Error saving font scale: $e');
    }
  }

  Future<void> toggleDailyMorningTips() async {
    _dailyMorningTips = !_dailyMorningTips;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('settings_daily_tips', _dailyMorningTips);
    } catch (e) {
      debugPrint('Error saving daily tips toggle: $e');
    }
  }

  Future<void> toggleWeeklyRecommendations() async {
    _weeklyRecommendations = !_weeklyRecommendations;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('settings_weekly_recs', _weeklyRecommendations);
    } catch (e) {
      debugPrint('Error saving weekly recommendations toggle: $e');
    }
  }

  Future<void> toggleReadingReminders() async {
    _readingReminders = !_readingReminders;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('settings_reading_reminders', _readingReminders);
    } catch (e) {
      debugPrint('Error saving reading reminders toggle: $e');
    }
  }

  Future<void> toggleAutoOfflineSave() async {
    _autoOfflineSave = !_autoOfflineSave;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('settings_auto_offline', _autoOfflineSave);
    } catch (e) {
      debugPrint('Error saving auto offline toggle: $e');
    }
  }

  Future<void> clearCache() async {
    _cacheSize = '0.0 MB';
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('settings_cache_size', '0.0 MB');
    } catch (e) {
      debugPrint('Error saving cache size: $e');
    }
  }
}
