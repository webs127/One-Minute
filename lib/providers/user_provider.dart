import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  static const String _nameKey = 'user_name';
  static const String _completedKey = 'onboarding_completed';

  String _name = '';
  bool _userSet = false;
  bool _onboardingCompleted = false;
  late final Future<void> _ready;

  UserProvider() {
    _ready = _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    if (!_userSet) {
      _name = prefs.getString(_nameKey) ?? '';
    }
    _onboardingCompleted = prefs.getBool(_completedKey) ?? false;
    notifyListeners();
  }

  Future<void> get ready => _ready;

  String get name => _name.isEmpty ? 'Friend' : _name;

  bool get onboardingCompleted => _onboardingCompleted;

  Future<void> setName(String value) async {
    final trimmed = value.trim();
    _userSet = true;
    _name = trimmed;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, trimmed);
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    _onboardingCompleted = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_completedKey, true);
    notifyListeners();
  }
}
