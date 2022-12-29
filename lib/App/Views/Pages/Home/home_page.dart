import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Home/home_controller.dart';
import 'package:flutterpp/App/Services/Auth/auth_services.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomePage')),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              AuthServices().signOut();
            },
            child: const Text('data'),
          ),
        ),
      ),
    );
  }
}
