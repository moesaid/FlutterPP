import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Pages/Auth/splash_page.dart';
import 'package:flutterpp/Config/app_binding.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter ++',
      initialBinding: AppBinding(),
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SplashPage(),
    );
  }
}
