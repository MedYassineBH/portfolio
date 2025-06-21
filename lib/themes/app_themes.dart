import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF00ADB5),
    scaffoldBackgroundColor: Colors.transparent,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF222831)),
      headlineMedium: TextStyle(
          fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF222831)),
      titleLarge: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF222831)),
      titleMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF222831)),
      bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF222831)),
      bodySmall: TextStyle(fontSize: 12, color: Color(0xFF222831)),
    ),
    iconTheme: const IconThemeData(color: Color(0xFF222831)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00ADB5),
        foregroundColor: Colors.white,
      ),
    ),
    cardTheme: const CardTheme(
      color: Color(0xFFEEEEEE),
      elevation: 4,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF00ADB5),
    scaffoldBackgroundColor: Colors.transparent,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFFEEEEEE)),
      headlineMedium: TextStyle(
          fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFEEEEEE)),
      titleLarge: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFFEEEEEE)),
      titleMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFFEEEEEE)),
      bodyMedium: TextStyle(fontSize: 14, color: Color(0xFFEEEEEE)),
      bodySmall: TextStyle(fontSize: 12, color: Color(0xFFEEEEEE)),
    ),
    iconTheme: const IconThemeData(color: Color(0xFFEEEEEE)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00ADB5),
        foregroundColor: Colors.white,
      ),
    ),
    cardTheme: const CardTheme(
      color: Color(0xFF393E46),
      elevation: 4,
    ),
  );
}
