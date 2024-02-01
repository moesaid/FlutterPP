import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_controller.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_single_project_code_gen.dart';

class BuildSingleProjectTabView extends StatelessWidget {
  const BuildSingleProjectTabView({
    super.key,
    required this.controller,
  });

  final ProjectSingleController controller;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        BuildSingleProjectCodeGen(
          localPath: controller.projectLocalPath,
        ),
        const Center(child: Text('Tasks')),
        const Center(child: Text('Members')),
      ],
    );
  }
}
