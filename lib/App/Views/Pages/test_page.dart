import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/x_controller.dart';
import 'package:get/get.dart';

class TestPage extends GetView<xController> {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<xController>(
      init: xController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('TestPage')),
          body: const SafeArea(
            child: Text('TestController'),
          ),
        );
      },
    );
  }
}
