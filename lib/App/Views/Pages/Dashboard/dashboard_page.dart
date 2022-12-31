import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/dashboard_controller.dart';
import 'package:get/get.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('DashboardPage')),
          body: const SafeArea(child: Text('DashboardController')),
        );
      },
    );
  }
}
