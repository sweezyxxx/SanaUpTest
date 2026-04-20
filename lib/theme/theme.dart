import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    surface: Color(0xFFF5F5F5),
    primary: Colors.white,
    secondary: Color(0xFF9E9E9E),
    tertiary: Color(0xFF4F46E5),
    inversePrimary: Color(0xFF1A1A2E),
    error: Color.fromARGB(255, 231, 41, 38),
    onSurface: Color(0xFF1A1A2E),
    onTertiary: Colors.white,
  ),
);
