import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Auth/login_controller.dart';
import 'package:flutterpp/App/Providers/Local/app_mode.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginPage'),
        actions: [
          // Switch(
          //     value: Get.isDarkMode,
          //     onChanged: (val) async {
          //       await AppMode().change();
          //     },
          //   )
          ObxValue(
            (data) => Switch(
              value: data.value,
              onChanged: (val) async {
                await AppMode().change();
                data.value = val;
              },
            ),
            Get.isDarkMode.obs,
          ),
        ],
      ),
      body: const SafeArea(child: Text('LoginController')),
    );
  }
}
