import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Auth/login_controller.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('LoginPage'),
        ),
      ),
    );
  }
}
