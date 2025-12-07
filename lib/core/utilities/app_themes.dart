import 'package:depi_graduation_project/core/utilities/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppThemes {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.main,
      onPrimary: Colors.white,
      secondary: Colors.white,
      onSecondary: AppColors.main,
      error: Colors.red.shade700,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppColors.main,
      ),
    ),
    cardColor: Colors.white,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.main,
      onPrimary: Colors.white,
      secondary: Colors.white,
      onSecondary: AppColors.main,
      error: Colors.red.shade700,
      onError: Colors.white,
      surface: AppColors.darkSurface,
      onSurface: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppColors.main,
      ),
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 17, 18, 21),
  );
}
