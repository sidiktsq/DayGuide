import 'package:flutter/material.dart';

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

  // Profile data
  String _userName = 'Budi Santoso';
  String _userHandle = '@budisantoso.id';
  int _userLevel = 4;
  int _streakDays = 7;

  String get themeMode => _themeMode;
  double get fontScale => _fontScale;
  bool get dailyMorningTips => _dailyMorningTips;
  bool get weeklyRecommendations => _weeklyRecommendations;
  bool get readingReminders => _readingReminders;
  bool get autoOfflineSave => _autoOfflineSave;
  String get userName => _userName;
  String get userHandle => _userHandle;
  int get userLevel => _userLevel;
  int get streakDays => _streakDays;

  void setThemeMode(String mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void increaseFontSize() {
    if (_fontScale < 1.3) {
      _fontScale += 0.1;
      notifyListeners();
    }
  }

  void decreaseFontSize() {
    if (_fontScale > 0.8) {
      _fontScale -= 0.1;
      notifyListeners();
    }
  }

  void toggleDailyMorningTips() {
    _dailyMorningTips = !_dailyMorningTips;
    notifyListeners();
  }

  void toggleWeeklyRecommendations() {
    _weeklyRecommendations = !_weeklyRecommendations;
    notifyListeners();
  }

  void toggleReadingReminders() {
    _readingReminders = !_readingReminders;
    notifyListeners();
  }

  void toggleAutoOfflineSave() {
    _autoOfflineSave = !_autoOfflineSave;
    notifyListeners();
  }

  void updateProfile({String? name, String? handle}) {
    if (name != null) _userName = name;
    if (handle != null) _userHandle = handle;
    notifyListeners();
  }
}
