import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/mockup_create_controller.dart';
import 'package:get/get.dart';

class MockupCreatePage extends GetView<MockupCreateController> {
  const MockupCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MockupCreateController>(
      init: MockupCreateController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('CreateMockupPage')),
          body: const SafeArea(
            child: Text('CreateMockupController'),
          ),
        );
      },
    );
  }
}
