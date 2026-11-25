import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.ink,
        primary: AppColors.ink,
        surface: AppColors.background,
      ),
      scaffoldBackgroundColor: AppColors.background,
    );

    return base.copyWith(
      textTheme: GoogleFonts.plusJakartaSansTextTheme(base.textTheme).apply(
        bodyColor: AppColors.ink,
        displayColor: AppColors.ink,
      ),
    );
  }

  /// Font monospace untuk label kecil seperti "01 / ENTER".
  static TextStyle mono({
    double fontSize = 11,
    Color color = AppColors.muted,
    double letterSpacing = 1,
  }) {
    return GoogleFonts.spaceMono(
      fontSize: fontSize,
      color: color,
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w400,
    );
  }
}
