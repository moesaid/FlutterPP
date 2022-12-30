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
    'error': Colors.red.shade500,
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
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          foregroundColor: Colors.white,
          backgroundColor: darkColors['secondary']!,
          disabledBackgroundColor: Colors.black12,
          splashFactory: NoSplash.splashFactory,
          shadowColor: Colors.transparent,
          elevation: 0,
          minimumSize: Size.zero,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.6,
          ),
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
        useIndicator: false,
        labelType: NavigationRailLabelType.none,
        elevation: 0,
        selectedIconTheme: const IconThemeData(color: Colors.white, size: 20),
        selectedLabelTextStyle: const TextStyle(color: Colors.white),
        unselectedLabelTextStyle: const TextStyle(color: Colors.white38),
        unselectedIconTheme: const IconThemeData(
          color: Colors.white38,
          size: 20,
          opacity: 0.5,
        ),
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
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white10),
          borderRadius: BorderRadius.circular(4),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white10),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white10),
          borderRadius: BorderRadius.circular(4),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white10),
          borderRadius: BorderRadius.circular(4),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white10),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white10),
          borderRadius: BorderRadius.circular(4),
        ),
        filled: true,
        isDense: true,
        fillColor: darkColors['primaryContainer'],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: const TextStyle(
          color: Colors.white38,
          fontSize: 12,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.6,
        ),
        labelStyle: const TextStyle(
          color: Colors.white38,
          fontSize: 12,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.6,
        ),
        errorStyle: TextStyle(
          color: darkColors['error']!,
          fontSize: 10,
          fontWeight: FontWeight.w300,
        ),
      ),
      textTheme: TextTheme(
        headline1: const TextStyle(
          color: Colors.white,
          fontSize: 96,
          fontWeight: FontWeight.w300,
          letterSpacing: -1.5,
        ),
        headline2: const TextStyle(
          color: Colors.white,
          fontSize: 60,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
        ),
        headline3: const TextStyle(
          color: Colors.white,
          fontSize: 48,
          fontWeight: FontWeight.w400,
        ),
        headline4: const TextStyle(
          color: Colors.white,
          fontSize: 34,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        headline5: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
        headline6: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        subtitle1: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
        ),
        subtitle2: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
        bodyText1: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
        bodyText2: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        button: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        caption: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          fontStyle: FontStyle.italic,
        ),
        overline: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
        selectionColor: Colors.white10,
        selectionHandleColor: Colors.white,
      ),
    );
  }
}
