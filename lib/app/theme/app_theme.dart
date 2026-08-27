import 'package:flutter/material.dart';
import 'package:oneminute/app/theme/app_colors.dart';

class AppTheme {
  static ThemeData light()  => ThemeData(
    scaffoldBackgroundColor: AppColors.background,
  );
  static ThemeData dark()  => ThemeData();
}