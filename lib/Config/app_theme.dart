import 'package:flutter/material.dart';

class AppTheme {
  ThemeData lightThemeData() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
    );
  }

  ThemeData darkThemeData() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color.fromRGBO(13, 15, 16, 1),
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        primaryContainer: Colors.grey,
        secondary: Colors.green,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(13, 15, 16, 1),
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}
