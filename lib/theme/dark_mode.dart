import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF121212),
    onSurface: Colors.white,
    primary: Color(0xFF2C2C2C),
    secondary: Color(0xFF3A3A3A),
    tertiary: Color(0xFF424242),
    inversePrimary: Color(0xFFE0E0E0),
  ),
  scaffoldBackgroundColor: Colors.black,

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    foregroundColor: Colors.white,
    surfaceTintColor: Colors.transparent, // 🔥 disables default tint
    elevation: 0,
  ),
);
