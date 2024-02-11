import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_files_controller.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/Files/build_project_single_files_body.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/Files/build_project_single_files_sidebar.dart';
import 'package:get/get.dart';

class ProjectSingleFilesPage extends GetView<ProjectSingleFilesController> {
  const ProjectSingleFilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleFilesController>(
      init: ProjectSingleFilesController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                BuildProjectSingleFilesBody(controller: controller),
                BuildProjectSingleFilesSidebar(controller: controller),
              ],
            ),
          ),
        );
      },
    );
  }
}
