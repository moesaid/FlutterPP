import 'package:flutter/material.dart';

class AppTheme {
  // dark mode colors
  var darkColors = {
    'scaffoldBackgroundColor': const Color.fromRGBO(22, 22, 24, 1),
    'seedColor': const Color.fromRGBO(51, 33, 99, 1),
    'primary': const Color.fromRGBO(51, 33, 99, 1),
    'secondary': const Color.fromRGBO(110, 77, 210, 1),
    'background': const Color.fromRGBO(10, 10, 10, 1),
    'onBackground': Colors.white,
    'primaryContainer': const Color.fromRGBO(33, 32, 36, 1),
    'secondaryContainer': const Color.fromRGBO(46, 46, 50, 1),
  };

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
      scaffoldBackgroundColor: darkColors['scaffoldBackgroundColor'],
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: darkColors['seedColor']!,
        primary: darkColors['primary']!,
        onPrimary: Colors.white,
        secondary: darkColors['secondary']!,
        onSecondary: Colors.white,
        background: darkColors['background']!,
        onBackground: Colors.white,
        primaryContainer: darkColors['primaryContainer']!,
        secondaryContainer: darkColors['secondaryContainer']!,
      ),
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      primaryColor: darkColors['primary']!,
      primaryColorLight: darkColors['secondary']!,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white10),
          disabledBackgroundColor: Colors.black12,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: Colors.grey.shade800,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(Colors.white38),
        trackColor: MaterialStateProperty.all(Colors.white10),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: darkColors['background'],
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
        unselectedIconTheme: const IconThemeData(
          color: Colors.white38,
          size: 20,
          opacity: 0.5,
        ),
        selectedLabelTextStyle: const TextStyle(
          color: Colors.white,
        ),
        unselectedLabelTextStyle: const TextStyle(
          color: Colors.white38,
        ),
        indicatorColor: Colors.transparent,
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
