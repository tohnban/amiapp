import 'package:ami_projecto/themes/appcolors.dart';
import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.darkPrimary,
  ).copyWith(
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: AppColors.darkTextPrimary,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      color: AppColors.darkTextSecondary,
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      color: Colors.white54,
      fontSize: 14,
    ),
  ),
);
