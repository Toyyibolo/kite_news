

import 'package:flutter/material.dart';

ThemeData kiteNewsDarkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF121212),
  primaryColor: Colors.amber[600],
  colorScheme: ColorScheme.dark(
    primary: Colors.amber[600]!,
    secondary: Colors.deepPurpleAccent,
    background: const Color(0xFF1E1E1E),
    surface: const Color(0xFF2C2C2C),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    foregroundColor: Colors.white,
    elevation: 1,
    titleTextStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 12, color: Colors.grey),
  ),
  chipTheme: ChipThemeData.fromDefaults(
    secondaryColor: Colors.amber,
    labelStyle: const TextStyle(),
    brightness: Brightness.dark,
  ),
  cardTheme: CardTheme(
    color: const Color(0xFF1F1F1F),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 2,
    margin: const EdgeInsets.symmetric(vertical: 8),
  ),
  snackBarTheme: const SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
  ),
);
