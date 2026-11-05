import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      useMaterial3: true,
    );
  }
}
