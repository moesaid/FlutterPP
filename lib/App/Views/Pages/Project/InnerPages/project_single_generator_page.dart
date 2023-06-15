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
          body: SafeArea(
            child: InteractiveViewer(
              scaleEnabled: true,
              // alignPanAxis: true,
              boundaryMargin: const EdgeInsets.all(100),
              child: Column(
                children: [
                  Container(
                    color: Colors.red,
                    width: 5000,
                    height: 200,
                    child: const Text('ProjectSingleGeneratorController'),
                  ),
                  Container(
                    color: Colors.red,
                    width: 5000,
                    height: 200,
                    child: const Text('ProjectSingleGeneratorController'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
