import 'package:destino_quisqueya_front/utilites/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  // Fuente por defecto: Google Fonts Imprima
  static const String fontFamily = /* non-null by design */
      // Nota: GoogleFonts.imprima().fontFamily retorna String?, usamos ! para asegurar.
      // Si en algún entorno devuelve null, puedes fallback a 'Imprima'.
      // ignore: unnecessary_non_null_assertion
      // ignore_for_file: constant_identifier_names
      // (mantener simple)
      // En práctica funciona bien:
      // GoogleFonts.imprima().fontFamily!;
      // Para const se requiere un literal, así que definimos con getter:
      'Imprima';

  static String get googleFontFamily =>
      GoogleFonts.imprima().fontFamily ?? fontFamily;

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
    bodyMedium: TextStyle(fontSize: 16, color: AppColors.lightTextSecondary),
    labelSmall: TextStyle(fontSize: 12, color: AppColors.lightTextSecondary),
  ).apply(fontFamily: googleFontFamily);

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
  ).apply(fontFamily: googleFontFamily);
}
