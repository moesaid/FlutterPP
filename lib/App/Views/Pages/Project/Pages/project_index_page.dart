import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/project_index_controller.dart';
import 'package:flutterpp/App/Views/Pages/Project/Pages/project_create_page.dart';
import 'package:flutterpp/App/Views/Pages/Project/Pages/project_single_page.dart';

import 'package:get/get.dart';

class ProjectIndexPage extends GetView<ProjectIndexController> {
  const ProjectIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProjectIndexController>(
        init: ProjectIndexController(),
        initState: (_) {},
        builder: (_) {
          return SafeArea(
            child: controller.isLoading
                ? const SizedBox()
                : controller.projects.isEmpty
                    ? ProjectCreatePage(
                        onColorChange: (val) => controller.onColorChange(val),
                        onSvgChange: (val) => controller.onSVGChange(val),
                        createTeam: (val) => controller.createProject(
                          formData: val,
                        ),
                        colors: controller.colors,
                        activeColors: controller.selectedColors,
                        activeSVG: controller.selectedSVG,
                        svgs: controller.svgs,
                      )
                    : ProjectSinglePage(projectIndexController: controller),
          );
        },
      ),
    );
  }
}
