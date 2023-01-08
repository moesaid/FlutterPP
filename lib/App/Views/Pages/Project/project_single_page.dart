import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/project_index_controller.dart';
import 'package:flutterpp/App/Controllers/Project/project_single_controller.dart';
import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Views/Global/build_sidebar.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_active_project_indecator.dart';
import 'package:get/get.dart';

class ProjectSinglePage extends GetView<ProjectSingleController> {
  const ProjectSinglePage({
    Key? key,
    required this.projectIndexController,
  }) : super(key: key);

  final ProjectIndexController projectIndexController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleController>(
      init: ProjectSingleController(),
      initState: (_) {},
      builder: (_) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildSidebar(
              child: BuildProjectSidebar(
                projectIndexController: projectIndexController,
                controller: controller,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('data'),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class BuildProjectSidebar extends StatelessWidget {
  const BuildProjectSidebar({
    Key? key,
    required this.projectIndexController,
    required this.controller,
  }) : super(key: key);

  final ProjectIndexController projectIndexController;
  final ProjectSingleController controller;

  @override
  Widget build(BuildContext context) {
    final ProjectModel activeProject = projectIndexController.activeProject;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildActiveProjectIndecator(
            activeProject: activeProject,
            projectIndexController: projectIndexController,
          ),
        ],
      ),
    );
  }
}
