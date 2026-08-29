import 'package:flutter/material.dart';
import 'package:oneminute/app/theme/app_theme.dart';

class ThemeProvider with ChangeNotifier{
  bool isLight = true;
  onThemeChanged(bool value) {
    isLight = value;
    notifyListeners();
  }

  ThemeData get theme => isLight ? AppTheme.light() : AppTheme.dark();
}