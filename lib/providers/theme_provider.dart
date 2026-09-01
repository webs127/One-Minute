import 'package:flutter/material.dart';
import 'package:oneminute/app/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier{
  static const String _themeKey = 'theme_is_light';
  bool isLight = true;

  ThemeProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    isLight = prefs.getBool(_themeKey) ?? true;
    notifyListeners();
  }

  onThemeChanged(bool value) async {
    isLight = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, value);
    notifyListeners();
  }

  ThemeData get theme => isLight ? AppTheme.light() : AppTheme.dark();
}