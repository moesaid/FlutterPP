import 'package:flutter/material.dart';

class AppTheme {
  ThemeData lightThemeData() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.grey.shade100,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: Colors.green,
        primary: Colors.green.shade700,
        onPrimary: Colors.white,
        secondary: Colors.red,
        onSecondary: Colors.white,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          // foregroundColor: Colors.white,
          side: BorderSide(color: Colors.grey.shade300),
          disabledBackgroundColor: Colors.grey.shade200,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  ThemeData darkThemeData() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color.fromRGBO(13, 15, 16, 1),
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: Colors.green,
        primary: Colors.green.shade700,
        onPrimary: Colors.white,
        secondary: Colors.red,
        onSecondary: Colors.white,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          // foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.white10),
          disabledBackgroundColor: Colors.black12,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: Colors.grey.shade800,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
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
