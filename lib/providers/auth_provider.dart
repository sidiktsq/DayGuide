import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isInitialized = false;
  String _userName = 'Pengguna Baru';
  String _userEmail = '';
  int _userLevel = 1;
  int _streakDays = 0;
  int _exp = 0;

  bool get isLoggedIn => _isLoggedIn;
  bool get isInitialized => _isInitialized;
  String get userName => _userName;
  String get userEmail => _userEmail;
  String get userHandle =>
      _userName.isNotEmpty ? '@${_userName.toLowerCase().replaceAll(RegExp(r'\s+'), '')}' : '@pengguna';
  int get userLevel => _userLevel;
  int get streakDays => _streakDays;
  int get exp => _exp;
  String get userRank {
    if (_userLevel == 1) return 'Pemula Penjelajah';
    if (_userLevel == 2) return 'Pembelajar Rajin';
    if (_userLevel == 3) return 'Praktisi Terampil';
    return 'Master Keseharian';
  }

  AuthProvider() {
    loadSession();
  }

  Future<void> loadSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isLoggedIn = prefs.getBool('auth_is_logged_in') ?? false;
      _userName = prefs.getString('auth_user_name') ?? 'Pengguna Baru';
      _userEmail = prefs.getString('auth_user_email') ?? '';
      _userLevel = prefs.getInt('auth_user_level') ?? 1;
      _streakDays = prefs.getInt('auth_streak_days') ?? 0;
      _exp = prefs.getInt('auth_exp') ?? 0;
    } catch (e) {
      debugPrint('Error loading auth session from SharedPreferences: $e');
    } finally {
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<void> _saveSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('auth_is_logged_in', _isLoggedIn);
      await prefs.setString('auth_user_name', _userName);
      await prefs.setString('auth_user_email', _userEmail);
      await prefs.setInt('auth_user_level', _userLevel);
      await prefs.setInt('auth_streak_days', _streakDays);
      await prefs.setInt('auth_exp', _exp);
    } catch (e) {
      debugPrint('Error saving auth session to SharedPreferences: $e');
    }
  }

  Future<void> login({required String email, String? name}) async {
    _isLoggedIn = true;
    _userEmail = email.trim();
    if (name != null && name.trim().isNotEmpty) {
      _userName = name.trim();
    } else {
      final namePart = email.split('@').first;
      _userName = namePart.isNotEmpty ? namePart : 'Pengguna Baru';
    }
    await _saveSession();
    notifyListeners();
  }

  Future<void> register({required String name, required String email, required String password}) async {
    _isLoggedIn = true;
    _userName = name.trim().isNotEmpty ? name.trim() : 'Pengguna Baru';
    _userEmail = email.trim();
    _userLevel = 1;
    _streakDays = 0;
    _exp = 0;
    await _saveSession();
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _userName = 'Pengguna Baru';
    _userEmail = '';
    _userLevel = 1;
    _streakDays = 0;
    _exp = 0;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_is_logged_in');
      await prefs.remove('auth_user_name');
      await prefs.remove('auth_user_email');
      await prefs.remove('auth_user_level');
      await prefs.remove('auth_streak_days');
      await prefs.remove('auth_exp');
    } catch (e) {
      debugPrint('Error clearing auth session: $e');
    }
    notifyListeners();
  }

  Future<void> updateProfile({String? name, String? email}) async {
    if (name != null && name.trim().isNotEmpty) _userName = name.trim();
    if (email != null && email.trim().isNotEmpty) _userEmail = email.trim();
    await _saveSession();
    notifyListeners();
  }

  Future<void> addExp(int amount) async {
    _exp += amount;
    if (_exp >= 100 * _userLevel) {
      _exp = 0;
      _userLevel += 1;
    }
    await _saveSession();
    notifyListeners();
  }
}
