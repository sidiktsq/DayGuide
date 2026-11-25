import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String _userName = 'Pengguna Baru';
  String _userEmail = '';
  int _userLevel = 1;
  int _streakDays = 0;
  int _exp = 0;

  bool get isLoggedIn => _isLoggedIn;
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

  void login({required String email, String? name}) {
    _isLoggedIn = true;
    _userEmail = email.trim();
    if (name != null && name.trim().isNotEmpty) {
      _userName = name.trim();
    } else {
      final namePart = email.split('@').first;
      _userName = namePart.isNotEmpty ? namePart : 'Pengguna Baru';
    }
    // Jika akun baru/login pertama kali, level tetap level 1
    notifyListeners();
  }

  void register({required String name, required String email, required String password}) {
    _isLoggedIn = true;
    _userName = name.trim().isNotEmpty ? name.trim() : 'Pengguna Baru';
    _userEmail = email.trim();
    _userLevel = 1; // Akun baru mulai dari level 1 (paling bawah)
    _streakDays = 0; // Akun baru streak 0 hari
    _exp = 0;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _userName = 'Pengguna Baru';
    _userEmail = '';
    _userLevel = 1;
    _streakDays = 0;
    _exp = 0;
    notifyListeners();
  }

  void updateProfile({String? name, String? email}) {
    if (name != null && name.trim().isNotEmpty) _userName = name.trim();
    if (email != null && email.trim().isNotEmpty) _userEmail = email.trim();
    notifyListeners();
  }

  void addExp(int amount) {
    _exp += amount;
    if (_exp >= 100 * _userLevel) {
      _exp = 0;
      _userLevel += 1;
    }
    notifyListeners();
  }
}
