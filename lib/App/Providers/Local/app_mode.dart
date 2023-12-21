import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppMode {
  final box = GetStorage();

  // read mode
  Future<void> init() async {
    String? value = box.read('mode');

    if (value == null) {
      await box.write('mode', 'dark');
      value = 'dark';
    }

    Get.changeThemeMode(value == 'dark' ? ThemeMode.dark : ThemeMode.light);
  }

  // write mode
  Future<void> change(BuildContext context) async {
    String? value = box.read('mode');

    if (value == 'dark') {
      await box.write('mode', 'light');
      Get.changeThemeMode(ThemeMode.light);
    } else {
      await box.write('mode', 'dark');
      Get.changeThemeMode(ThemeMode.dark);
    }

    // remove all routes and push home
    Get.offAllNamed('/');
  }

  // delete mode
  Future<void> remove() async {
    await box.remove('mode');
  }
}
