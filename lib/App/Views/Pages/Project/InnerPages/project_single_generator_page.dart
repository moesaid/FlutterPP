import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/project_single_generator_controller.dart';
import 'package:get/get.dart';

class ProjectSingleGeneratorPage
    extends GetView<ProjectSingleGeneratorController> {
  const ProjectSingleGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleGeneratorController>(
      init: ProjectSingleGeneratorController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('ProjectSingleGeneratorPage')),
          body: const SafeArea(child: Text('ProjectSingleGeneratorController')),
        );
      },
    );
  }
}
