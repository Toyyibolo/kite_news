import 'package:flutter/material.dart';

ThemeData kiteNewsLightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.grey[100],
  primaryColor: Colors.deepPurple,
  colorScheme: ColorScheme.light(
    primary: Colors.deepPurple,
    secondary: Colors.amber[700]!,
    surface: Color(0xfff5f7fa),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
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
    secondaryColor: Colors.deepPurple,
    labelStyle: const TextStyle(),
    brightness: Brightness.light,
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 2,
    margin: const EdgeInsets.symmetric(vertical: 8),
  ),
  snackBarTheme: const SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
  ),
);
