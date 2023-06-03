import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/mockup_index_controller.dart';
import 'package:flutterpp/App/Views/Global/build_page_layout.dart';
import 'package:get/get.dart';

class MockupIndexPage extends GetView<MockupIndexController> {
  const MockupIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MockupIndexController>(
      init: MockupIndexController(),
      initState: (_) {},
      builder: (_) {
        return const BuildPageLayout(
          child: Text('MockupIndexController'),
        );
      },
    );
  }
}
