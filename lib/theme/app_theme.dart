import 'package:destino_quisquella_front/utilites/app_colors.dart';
import 'package:flutter/material.dart';

import 'app_typography.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightBackground,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.lightPrimary,
      brightness: Brightness.light,
      primary: AppColors.lightPrimary,
      surface: AppColors.lightSurface,
      // surface: AppColors.lightBackground,
      onPrimary: AppColors.lightTextPrimary,
      onSurface: AppColors.lightTextPrimary,
      // onBackground: AppColors.lightTextPrimary,
      onSurfaceVariant: AppColors.lightTextPrimary,
      onError: AppColors.lightTextPrimary,
      // onErrorForeground: AppColors.lightTextPrimary,
      // surfaceVariant: AppColors.lightSurfaceVariant,
      // outline: AppColors.lightOutline,
      // shadow: AppColors.lightShadow,
      // primaryContainer: AppColors.lightPrimaryContainer,
      // secondaryContainer: AppColors.lightSecondaryContainer,
      // tertiaryContainer: AppColors.lightTertiaryContainer,
      // errorContainer: AppColors.lightErrorContainer
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightSurface,
      foregroundColor: AppColors.lightTextPrimary,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: const CardThemeData(
      color: AppColors.lightSurface,
      elevation: 2,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPrimary,
        foregroundColor: Colors.white,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    tabBarTheme: TabBarThemeData(dividerColor: Colors.transparent),
    iconTheme: const IconThemeData(color: AppColors.lightTextSecondary),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.lightPrimary,
      foregroundColor: Colors.white,
    ),
    textTheme: AppTypography.lightTextTheme,
    fontFamily: AppTypography.googleFontFamily,
    useMaterial3: true,
    bottomAppBarTheme: BottomAppBarThemeData(color: AppColors.lightSurface),
    // inputDecorationTheme: const InputDecorationTheme(
    //   border: OutlineInputBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(12)),
    //     borderSide: BorderSide.none,
    //   ),
    //   enabledBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(12)),
    //     borderSide: BorderSide.none,
    //   ),
    //   focusedBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(12)),
    //     borderSide: BorderSide.none,
    //   ),
    //   errorBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(12)),
    //     borderSide: BorderSide.none,
    //   ),
    //   disabledBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(12)),
    //     borderSide: BorderSide.none,
    //   ),
    // ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.darkPrimary,
      brightness: Brightness.dark,
      primary: AppColors.darkPrimary,
      surface: AppColors.darkSurface,
      // background: AppColors.darkBackground,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.darkTextPrimary,
      elevation: 0,
      centerTitle: true,
    ),
    tabBarTheme: TabBarThemeData(dividerColor: Colors.transparent),
    cardTheme: const CardThemeData(
      color: AppColors.darkSurface,
      elevation: 2,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: Colors.white,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.darkTextPrimary),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: Colors.white,
    ),
    textTheme: AppTypography.darkTextTheme,
    fontFamily: AppTypography.googleFontFamily,
    useMaterial3: true,
    bottomAppBarTheme: BottomAppBarThemeData(color: AppColors.darkSurface),
  );
}
