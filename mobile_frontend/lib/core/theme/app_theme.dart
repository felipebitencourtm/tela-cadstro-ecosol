import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            fixedSize: const Size(450, 60),
            padding: const EdgeInsets.symmetric(horizontal:16, vertical:12),
            elevation: 0,
            shape: const LinearBorder(),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled:true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal:16, vertical:12),

          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
          ),

          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
          ),

          constraints: const BoxConstraints(
            minHeight: 80.0,
            maxHeight: 80.0,
          ),
        ),
      );
}