import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Auth/splash_controller.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      initState: (_) {},
      builder: (context) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const FlutterLogo(size: 100),
                const SizedBox(height: 10),
                const Text('Flutter ++'),
                const Text('v0.0.1'),
                const SizedBox(height: 20),
                SizedBox(
                  width: Get.width * 0.02,
                  height: Get.width * 0.02,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
