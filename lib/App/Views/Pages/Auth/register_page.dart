import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Auth/register_controller.dart';
import 'package:flutterpp/App/Services/Auth/auth_services.dart';
import 'package:get/get.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await AuthServices().signInWithOtp(
                    email: 'masedup@gmail.com',
                  );
                },
                child: const Text('register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
