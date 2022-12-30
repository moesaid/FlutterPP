import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildSnackBar {
  final String title, message;

  BuildSnackBar({
    required this.title,
    required this.message,
  });

  // error snackbar
  error() {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.red.shade700,
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  // success snackbar
  success() {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.green.shade700,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }
}
