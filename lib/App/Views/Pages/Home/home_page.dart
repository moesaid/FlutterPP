import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Home/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomePage')),
      body: const SafeArea(child: Text('HomeController')),
    );
  }
}
