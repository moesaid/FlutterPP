import 'dart:math';

import 'package:flutter/material.dart';

class AppGradients {
  // get gradient colros
  static LinearGradient getGradient({
    required List<Color> colors,
    firstOpacity = 1.0,
    secondOpacity = 1.0,
  }) {
    return LinearGradient(
      colors: [
        colors[0].withValues(alpha: firstOpacity),
        colors[1].withValues(alpha: secondOpacity),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  // get random 20 array of 2 colors
  static List<List<Color>> getRandomColors() {
    // list of list of colors
    List<List<Color>> colors = [];

    // get random colors
    for (int i = 0; i < 100; i++) {
      List<Color> randomColors = [];

      // get random 2 color
      for (int j = 0; j < 2; j++) {
        // get random color
        int randomColorIndex = Random().nextInt(randomColros.length);
        String randomColor = randomColros[randomColorIndex];

        // convert hex color to color
        int intColor = int.parse(randomColor.substring(1), radix: 16);
        Color color = Color.fromARGB(0xFF, (intColor >> 16) & 0xFF,
            (intColor >> 8) & 0xFF, intColor & 0xFF);

        // add color to list
        randomColors.add(color);
      }

      // add list of colors to list
      colors.add(randomColors);
    }

    // return list of colors
    return colors;
  }

  // random colors
  static List randomColros = [
    "#FF6633",
    "#FFB399",
    "#FF33FF",
    "#FFFF99",
    "#00B3E6",
    "#E6B333",
    "#3366E6",
    "#999966",
    "#99FF99",
    "#B34D4D",
    "#80B300",
    "#809900",
    "#E6B3B3",
    "#6680B3",
    "#66991A",
    "#FF99E6",
    "#CCFF1A",
    "#FF1A66",
    "#E6331A",
    "#33FFCC",
    "#66994D",
    "#B366CC",
    "#4D8000",
    "#B33300",
    "#CC80CC",
    "#66664D",
    "#991AFF",
    "#E666FF",
    "#4DB3FF",
    "#1AB399",
    "#E666B3",
    "#33991A",
    "#CC9999",
    "#B3B31A",
    "#00E680",
    "#4D8066",
    "#809980",
    "#E6FF80",
    "#1AFF33",
    "#999933",
    "#FF3380",
    "#CCCC00",
    "#66E64D",
    "#4D80CC",
    "#9900B3",
    "#E64D66",
    "#4DB380",
    "#FF4D4D",
    "#99E6E6",
    "#6666FF",
  ];
}
