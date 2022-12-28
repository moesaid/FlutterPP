import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Auth/login_controller.dart';
import 'package:flutterpp/App/Services/Auth/auth_services.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text('LoginPage'),
              SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {
              //     AuthServices().register(
              //       email: 'masedup@gmail.com',
              //       password: 'password',
              //       name: 'moe',
              //     );
              //   },
              //   child: const Text('register'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
