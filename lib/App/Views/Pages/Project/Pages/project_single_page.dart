import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/project_single_controller.dart';
import 'package:get/get.dart';

class ProjectSinglePage extends GetView<ProjectSingleController> {
  const ProjectSinglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleController>(
      init: ProjectSingleController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('MyPage')),
          body: const SafeArea(child: Text('MyController')),
        );
      },
    );
  }
}
