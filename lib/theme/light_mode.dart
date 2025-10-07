import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    surface: Color(0xFFF2F2F2),
    onSurface: Colors.black,
    primary: Color(0xFFB0BEC5),
    secondary: Color(0xFFE0E0E0),
    tertiary: Color.fromARGB(255, 0, 0, 0),
    inversePrimary: Color(0xFF212121),
  ),
  scaffoldBackgroundColor: const Color(0xFFF5F5F5),

  // ✅ Explicitly override Material 3 defaults
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFD6D6D6),
    foregroundColor: Colors.black,
    surfaceTintColor: Colors.transparent, // 🔥 critical for M3
    elevation: 0,
  ),
);
