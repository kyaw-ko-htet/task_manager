import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color colorPrimary = Color(0xFF37B6E9);
  static const Color colorSecondary = Color(0xFF242C3B);
  static const Color colorBackground = Color(0xFF353F54);
  static const Color colorSurface = Color(0xFF4B4CED);
  static const Color colorOnPrimary = Color(0xFFFFFFFF);
  static const Color colorOnSurface = Color(0xFFFFFFFF);
  static const Color colorOnSurfaceVariant = Color(0xFFB0BEC5);
  static const Color colorDisabled = Color(0xFF607D8B);
  static const Color colorSuccess = Color(0xFF4CAF50);
  static const Color colorWarning = Color(0xFFFFB300);
  static const Color colorError = Color(0xFFEF5350);
  static const Color colorDivider = Color(0x1FFFFFFF); // white @ 12%
  static const Color colorBorder = Color(0x33FFFFFF); // white @ 20%

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: colorPrimary,
        onPrimary: colorOnPrimary,
        secondary: colorSecondary,
        onSecondary: colorOnPrimary,
        surface: colorSurface,
        onSurface: colorOnSurface,
        error: colorError,
        onError: colorOnPrimary,
      ),
      scaffoldBackgroundColor: colorBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: colorPrimary,
        foregroundColor: colorOnPrimary,
        elevation: 0,
        scrolledUnderElevation: 2,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: colorOnPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: colorSurface,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 4),
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
        foregroundColor: colorOnPrimary,
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
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: colorPrimary),
      listTileTheme: const ListTileThemeData(
        titleTextStyle: TextStyle(fontSize: 16, color: colorOnSurface),
        subtitleTextStyle: TextStyle(fontSize: 14, color: colorOnSurfaceVariant),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400, height: 1.12, color: colorOnSurface),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, height: 1.29, color: colorOnSurface),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, height: 1.27, color: colorOnSurface),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 1.50, color: colorOnSurface),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.50, color: colorOnSurface),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.43, color: colorOnSurface),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 1.33, color: colorOnSurfaceVariant),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 1.43, color: colorOnSurface),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, height: 1.33, color: colorOnSurfaceVariant),
      ),
    );
  }
}
