// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ColorHelper {
  // Color to Hex
  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2, 8)}';
  }

  // Color to Hex without #
  static String colorToHexWithoutHash(Color color) {
    return color.value.toRadixString(16).substring(2, 8);
  }

  // Hex to Color
  static Color hexToColor(String hex) {
    // of length less than 6
    if (hex.length < 6) {
      return Colors.black;
    }

    // if doesn't start with # add #
    if (!hex.startsWith('#')) {
      hex = '#$hex';
    }
    return Color(int.parse(hex.substring(1, 7), radix: 16) + 0xFF000000);
  }
}

extension ColorExtension on Color {
  MaterialColor toMaterialColor() {
    Map<int, Color> swatch = {
      50: withValues(alpha: 0.1),
      100: withValues(alpha: 0.2),
      200: withValues(alpha: 0.3),
      300: withValues(alpha: 0.4),
      400: withValues(alpha: 0.5),
      500: withValues(alpha: 0.6),
      600: withValues(alpha: 0.7),
      700: withValues(alpha: 0.8),
      800: withValues(alpha: 0.9),
      900: withValues(alpha: 1.0),
    };

    MaterialColor materialColor = MaterialColor(value, swatch);
    return materialColor;
  }
}
