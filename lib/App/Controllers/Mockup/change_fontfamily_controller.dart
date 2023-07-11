import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeFontfamilyController extends GetxController {
  final _activeFontFamily = GoogleFonts.roboto().obs;
  TextStyle get activeFontFamily => _activeFontFamily.value;

  void changeFontFamily({
    required TextStyle fontFamily,
  }) {
    _activeFontFamily.value = fontFamily;
    update();
  }
}
