import 'package:flutter/material.dart';
import 'package:oneminute/app/theme/app_colors.dart';

class AppTheme {
  static ThemeData light() => ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    cardTheme: CardThemeData(
      color: AppColors.background,
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    appBarTheme: AppBarThemeData(backgroundColor: AppColors.background),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(AppColors.surfaceWhite),
      trackColor: WidgetStatePropertyAll(AppColors.primary),
    ),
    iconTheme: IconThemeData(color: AppColors.secondaryText),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.primaryText,
      ),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.primaryText,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.surfaceBlack,
      ),
      displayMedium: TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.surfaceBlack,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.secondaryText,
      ),
    ),
  );
  static ThemeData dark() => ThemeData(
    scaffoldBackgroundColor: AppColors.darkbackground,
    cardTheme: CardThemeData(
      color: AppColors.darksurfaceBlack,
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkborder),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(AppColors.surfaceWhite),
      trackColor: WidgetStatePropertyAll(AppColors.darkprimary),
    ),
    iconTheme: IconThemeData(color: AppColors.surfaceWhite),
    appBarTheme: AppBarThemeData(
      backgroundColor: AppColors.darkbackground,
      iconTheme: IconThemeData(color: AppColors.surfaceWhite),
    ),
    textTheme: TextTheme(
      displayMedium: TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.surfaceWhite,
      ),
      headlineLarge: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.surfaceWhite,
      ),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.surfaceWhite,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.surfaceWhite,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.surfaceWhite,
      ),
      // headlineMedium: TextStyle(
      //   fontWeight: FontWeight.bold,
      //   color: AppColors.surfaceWhite,
      // ),
      // titleMedium: TextStyle(
      //   fontWeight: FontWeight.w600,
      //   color: AppColors.surfaceWhite,
      // ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.secondaryText,
      ),
      // titleSmall: TextStyle(
      //   fontWeight: FontWeight.w600,
      //   color: AppColors.surfaceWhite,
      // ),
    ),
  );
}
