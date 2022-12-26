import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Auth/splash_controller.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Splash Page')),
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('SplashController'),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.changeThemeMode(
                        Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                      );
                    },
                    child: const Text('switch'),
                  ),
                  const SizedBox(width: 20),
                  const ElevatedButton(
                    onPressed: null,
                    child: Text('null'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Get.changeThemeMode(
                        Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                      );
                    },
                    child: const Text('switch'),
                  ),
                  const SizedBox(width: 20),
                  const OutlinedButton(
                    onPressed: null,
                    child: Text('null'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Get.changeThemeMode(
                        Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                      );
                    },
                    child: const Text('switch'),
                  ),
                  const SizedBox(width: 20),
                  const OutlinedButton(
                    onPressed: null,
                    child: Text('null'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
