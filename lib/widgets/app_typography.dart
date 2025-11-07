import 'package:flutter/material.dart';
import '../utilities/const/app_colors.dart';

class AppTypography {
  static const String fontFamily = 'Poppins';

  static final TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: AppColors.lightTextPrimary,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.lightTextPrimary,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.lightTextPrimary,
    ),
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.lightTextSecondary),
    labelSmall: TextStyle(fontSize: 12, color: AppColors.lightTextSecondary),
  ).apply(fontFamily: fontFamily);

  static final TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: AppColors.darkTextPrimary,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.darkTextPrimary,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.darkTextPrimary,
    ),
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.darkTextSecondary),
    labelSmall: TextStyle(fontSize: 12, color: AppColors.darkTextSecondary),
  ).apply(fontFamily: fontFamily);
}
