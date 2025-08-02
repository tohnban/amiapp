import 'package:ami_projecto/themes/appcolors.dart';
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.lightPrimary,
  ).copyWith(
    background: AppColors.lightBackground,
    surface: AppColors.lightSurface,
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: AppColors.lightTextPrimary,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      color: AppColors.lightTextSecondary,
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      color: Colors.black54,
      fontSize: 14,
    ),
  ),
);
