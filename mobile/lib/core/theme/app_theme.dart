import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // ---------------------------------------------------------------------------
  // Color palette — clean & modern (light theme)
  // ---------------------------------------------------------------------------
  static const Color colorPrimary = Color(0xFF6366F1); // Indigo 500
  static const Color colorSecondary = Color(0xFF22D3EE); // Cyan 400
  static const Color colorBackground = Color(0xFFF9FAFB); // Gray 50
  static const Color colorSurface = Color(0xFFFFFFFF); // White
  static const Color colorOnPrimary = Color(0xFFFFFFFF);
  static const Color colorOnSecondary = Color(0xFF111827);
  static const Color colorOnSurface = Color(0xFF111827);
  static const Color colorOnSurfaceVariant = Color(0xFF6B7280);
  static const Color colorDisabled = Color(0xFF9CA3AF);
  static const Color colorSuccess = Color(0xFF10B981);
  static const Color colorWarning = Color(0xFFF59E0B);
  static const Color colorError = Color(0xFFEF4444);
  static const Color colorInfo = Color(0xFF6366F1);
  static const Color colorDivider = Color(0x1F000000); // black @ 12%
  static const Color colorBorder = Color(0x33000000); // black @ 20%
  static const Color colorOverlay = Color(0x8A000000); // black @ 54%

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: colorPrimary,
        onPrimary: colorOnPrimary,
        secondary: colorSecondary,
        onSecondary: colorOnSecondary,
        surface: colorSurface,
        onSurface: colorOnSurface,
        error: colorError,
        onError: colorOnPrimary,
      ),
      scaffoldBackgroundColor: colorBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: colorPrimary,
        foregroundColor: colorOnPrimary,
        elevation: 0,
        scrolledUnderElevation: 2,
        centerTitle: false,
        titleTextStyle: GoogleFonts.roboto(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: colorOnPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: colorSurface,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: colorBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: colorPrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: colorError),
        ),
        labelStyle: const TextStyle(color: colorOnSurfaceVariant),
        hintStyle: const TextStyle(color: colorOnSurfaceVariant),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrimary,
          foregroundColor: colorOnPrimary,
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorPrimary,
          side: const BorderSide(color: colorPrimary),
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorPrimary,
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: colorSecondary,
        foregroundColor: colorOnSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      dividerTheme: const DividerThemeData(color: colorDivider, thickness: 1),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorSurface,
        contentTextStyle: const TextStyle(color: colorOnSurface),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: colorPrimary,
      ),
      listTileTheme: ListTileThemeData(
        titleTextStyle: GoogleFonts.roboto(fontSize: 16, color: colorOnSurface),
        subtitleTextStyle: GoogleFonts.roboto(
          fontSize: 14,
          color: colorOnSurfaceVariant,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.roboto(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          height: 1.12,
          color: colorOnSurface,
        ),
        headlineMedium: GoogleFonts.roboto(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          height: 1.29,
          color: colorOnSurface,
        ),
        titleLarge: GoogleFonts.roboto(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          height: 1.27,
          color: colorOnSurface,
        ),
        titleMedium: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.50,
          color: colorOnSurface,
        ),
        bodyLarge: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.50,
          color: colorOnSurface,
        ),
        bodyMedium: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.43,
          color: colorOnSurface,
        ),
        bodySmall: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.33,
          color: colorOnSurfaceVariant,
        ),
        labelLarge: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 1.43,
          color: colorOnSurface,
        ),
        labelMedium: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.33,
          color: colorOnSurfaceVariant,
        ),
      ),
    );
  }
}
