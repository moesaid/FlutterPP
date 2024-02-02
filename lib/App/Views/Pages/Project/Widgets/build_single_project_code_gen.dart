import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_config_controller.dart';
import 'package:get/get.dart';

class BuildSingleProjectCodeGen extends GetView<ProjectSingleConfigController> {
  final String? localPath;
  const BuildSingleProjectCodeGen({
    super.key,
    this.localPath,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleConfigController>(
      init: ProjectSingleConfigController(),
      initState: (_) {},
      builder: (_) {
        return Center(
          child: GestureDetector(
            // onTap: () => controller.getPath(),
            child: const Text('Tasks'),
          ),
        );
      },
    );
  }
}
