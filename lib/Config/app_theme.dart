import 'package:flutter/material.dart';

class AppTheme {
  // dark mode colors
  var darkColors = {
    'scaffoldBackgroundColor': const Color(0xFF161618),
    'seedColor': const Color(0xFF332163),
    'primary': const Color.fromRGBO(51, 33, 99, 1),
    'secondary': const Color(0xFF6E4DD2),
    'background': const Color(0xFF0A0A0A),
    'dark': const Color.fromRGBO(0, 0, 0, 1),
    'onBackground': Colors.white,
    'primaryContainer': const Color.fromRGBO(33, 32, 36, 1),
    'secondaryContainer': const Color.fromRGBO(46, 46, 50, 1),
    'error': Colors.red.shade500,
  };

  var lightColors = {
    'scaffoldBackgroundColor': const Color.fromRGBO(240, 240, 240, 1),
    'seedColor': const Color.fromRGBO(51, 33, 99, 1),
    'primary': const Color.fromRGBO(51, 33, 99, 1),
    'secondary': const Color.fromRGBO(110, 77, 210, 1),
    'background': const Color.fromRGBO(250, 250, 250, 1),
    'dark': const Color.fromRGBO(255, 255, 255, 1),
    'onBackground': Colors.black,
    'primaryContainer': const Color.fromRGBO(240, 240, 240, 1),
    'secondaryContainer': const Color.fromRGBO(220, 220, 220, 1),
    'error': Colors.red.shade500,
  };

  ThemeData lightThemeData() {
    return ThemeData(
      scaffoldBackgroundColor: lightColors['scaffoldBackgroundColor'],
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: lightColors['seedColor']!,
        primary: lightColors['primary']!,
        onPrimary: Colors.black,
        secondary: lightColors['secondary']!,
        onSecondary: Colors.black,
        onSurface: Colors.black,
        primaryContainer: lightColors['primaryContainer']!,
        secondaryContainer: lightColors['secondaryContainer']!,
        surface: lightColors['scaffoldBackgroundColor']!,
      ),
      dialogBackgroundColor: lightColors['primaryContainer']!,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      primaryColor: lightColors['primary']!,
      primaryColorLight: lightColors['secondary']!,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: lightColors['secondaryContainer']!),
          backgroundColor:
              lightColors['primaryContainer']!.withValues(alpha: 0.3),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          foregroundColor: lightColors['secondary']!,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          foregroundColor: Colors.black,
          backgroundColor: lightColors['secondary']!,
          disabledBackgroundColor: Colors.black12,
          splashFactory: NoSplash.splashFactory,
          shadowColor: Colors.transparent,
          minimumSize: Size.zero,
          elevation: 0,
          padding: const EdgeInsets.only(
            left: 22,
            right: 22,
            top: 16,
            bottom: 11 + 8,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          textStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.6,
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: Colors.grey.shade800,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.black38),
        trackColor: WidgetStateProperty.all(Colors.black),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: lightColors['background'],
        useIndicator: false,
        labelType: NavigationRailLabelType.none,
        elevation: 0,
        selectedIconTheme: const IconThemeData(color: Colors.black, size: 20),
        selectedLabelTextStyle: const TextStyle(color: Colors.black),
        unselectedLabelTextStyle: const TextStyle(color: Colors.black38),
        unselectedIconTheme: const IconThemeData(
          color: Colors.black38,
          size: 20,
          opacity: 0.5,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: lightColors['dark']!,
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
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(4),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(4),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(4),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(4),
        ),
        filled: true,
        isDense: true,
        fillColor: lightColors['primaryContainer'],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: const TextStyle(
          color: Colors.black38,
          fontSize: 12,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.6,
        ),
        labelStyle: const TextStyle(
          color: Colors.black38,
          fontSize: 12,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.6,
        ),
        errorStyle: TextStyle(
          color: lightColors['error']!,
          fontSize: 10,
          fontWeight: FontWeight.w300,
        ),
      ),
      textTheme: const TextTheme(
          // ... (Other text styles)
          ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
        selectionColor: Colors.black12,
        selectionHandleColor: Colors.black,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: lightColors['secondary'],
        foregroundColor: Colors.black,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        splashColor: Colors.black12,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          filled: true,
          isDense: true,
          fillColor: Colors.black12,
          contentPadding: EdgeInsets.all(12),
          hintStyle: TextStyle(
            color: Colors.black38,
            fontSize: 12,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.6,
          ),
          labelStyle: TextStyle(
            color: Colors.black38,
            fontSize: 12,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.6,
          ),
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 10,
            fontWeight: FontWeight.w300,
          ),
        ),
        menuStyle: MenuStyle(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
          ),
          backgroundColor: WidgetStateProperty.all(
            Colors.black12,
          ),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: lightColors['primaryContainer'],
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        contentTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        iconColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        surfaceTintColor: Colors.black,
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
        primaryContainer: darkColors['primaryContainer']!,
        secondaryContainer: darkColors['secondaryContainer']!,
        surface: darkColors['scaffoldBackgroundColor']!,
        onSurface: Colors.white,
      ),
      dialogBackgroundColor: darkColors['primaryContainer']!,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      primaryColor: darkColors['primary']!,
      primaryColorLight: darkColors['secondary']!,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: darkColors['secondaryContainer']!),
          backgroundColor:
              darkColors['primaryContainer']!.withValues(alpha: 0.3),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          foregroundColor: darkColors['secondary']!,
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
          minimumSize: Size.zero,
          elevation: 0,
          padding: const EdgeInsets.only(
            left: 22,
            right: 22,
            top: 16,
            bottom: 16,
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
        thumbColor: WidgetStateProperty.all(Colors.white38),
        trackColor: WidgetStateProperty.all(Colors.white10),
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
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: darkColors['dark']!,
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
      chipTheme: ChipThemeData(
        backgroundColor: darkColors['primaryContainer']!,
        selectedColor: darkColors['primary']!,
        side: const BorderSide(color: Colors.white10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          color: Colors.white,
          fontSize: 96,
          fontWeight: FontWeight.w300,
          letterSpacing: -1.5,
        ),
        displayMedium: const TextStyle(
          color: Colors.white,
          fontSize: 60,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
        ),
        displaySmall: const TextStyle(
          color: Colors.white,
          fontSize: 48,
          fontWeight: FontWeight.w400,
        ),
        headlineMedium: const TextStyle(
          color: Colors.white,
          fontSize: 34,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        headlineSmall: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
        titleLarge: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        titleMedium: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
        ),
        titleSmall: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
        bodyLarge: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
        bodyMedium: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        labelLarge: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        bodySmall: TextStyle(
          color: Colors.white.withValues(alpha: 0.5),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          fontStyle: FontStyle.italic,
        ),
        labelSmall: const TextStyle(
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
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkColors['secondary'],
        foregroundColor: Colors.white,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        splashColor: Colors.white10,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white10),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white10),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white10),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white10),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white10),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white10),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          filled: true,
          isDense: true,
          fillColor: Colors.white10,
          contentPadding: EdgeInsets.all(12),
          hintStyle: TextStyle(
            color: Colors.white38,
            fontSize: 12,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.6,
          ),
          labelStyle: TextStyle(
            color: Colors.white38,
            fontSize: 12,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.6,
          ),
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 10,
            fontWeight: FontWeight.w300,
          ),
        ),
        menuStyle: MenuStyle(
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
          ),
          backgroundColor: WidgetStateProperty.all(
            Colors.white10,
          ),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: darkColors['primaryContainer'],
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        contentTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        iconColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        surfaceTintColor: Colors.white,
      ),
    );
  }
}
