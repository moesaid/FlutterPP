import 'package:flutter/material.dart';
import 'package:flutterpp/Helpers/helper_colors.dart';
import 'package:get/get.dart';

class PickupColorController extends GetxController {
  // Color for the picker shown in Card on the screen.
  final _screenPickerColor = Colors.blue.obs;
  Color get screenPickerColor => _screenPickerColor.value;

  // Color for the picker in a dialog using onChanged.
  final _dialogPickerColor = Colors.red.obs;
  Color get dialogPickerColor => _dialogPickerColor.value;

  // Color for picker using the color select dialog.
  final _dialogSelectColor = const Color(0xFFA239CA).obs;
  Color get dialogSelectColor => _dialogSelectColor.value;

  void onColorChanged({required Color color, Function(Color color)? callback}) {
    // color to material color
    MaterialColor materialColor = color.toMaterialColor();
    _screenPickerColor.value = materialColor;
    _dialogPickerColor.value = materialColor;
    _dialogSelectColor.value = materialColor;
    update();

    if (callback != null) {
      callback(color);
    }
  }
}
