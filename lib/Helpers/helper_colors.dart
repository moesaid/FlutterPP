import 'package:flutter/material.dart';

class ColorHelper {
  // Color to Hex
  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2, 8)}';
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
