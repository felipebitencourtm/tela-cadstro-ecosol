import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xF5F5F5F5),
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight(700),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Color(0xF9F9F9F9),
        fixedSize: const Size(450, 70),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        elevation: 0,
        shape: const LinearBorder(),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
      ),

      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
      ),

      constraints: const BoxConstraints(minHeight: 80.0, maxHeight: 80.0),
    ),
  );
}
