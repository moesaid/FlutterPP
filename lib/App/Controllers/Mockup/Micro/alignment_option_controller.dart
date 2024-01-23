import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlignmentOptionController extends GetxController {
  final _alignment = MainAxisAlignment.center.obs;
  MainAxisAlignment get alignment => _alignment.value;

  setInitialAlignment(MainAxisAlignment? alignment) {
    if (alignment == null) return;
    _alignment.value = alignment;
  }

  void setAlignment({
    MainAxisAlignment? alignment,
    Function(MainAxisAlignment)? onToggle,
  }) {
    if (alignment == null) return;

    _alignment.value = alignment;
    update();

    onToggle?.call(alignment);
  }
}
