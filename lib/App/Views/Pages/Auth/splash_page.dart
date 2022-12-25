import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Auth/splash_controller.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SplashPage')),
      body: const SafeArea(
        child: Text('SplashController'),
      ),
    );
  }
}
