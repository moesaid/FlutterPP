import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_api_gen_controller.dart';
import 'package:flutterpp/App/Views/Global/build_empty_page.dart';
import 'package:get/get.dart';

class ProjectSingleApiGenPage extends GetView<ProjectSingleApiGenController> {
  const ProjectSingleApiGenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleApiGenController>(
      init: ProjectSingleApiGenController(),
      initState: (_) {},
      builder: (_) {
        return const Scaffold(
          body: SafeArea(
            child: ProjectSingleApiGenEmptyState(),
          ),
        );
      },
    );
  }
}

class ProjectSingleApiGenEmptyState extends StatelessWidget {
  const ProjectSingleApiGenEmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BuildEmptyPage(
        title: 'no api classes found for this project'.capitalize!,
        hasButton: true,
        buttonTitle: 'create your first use case'.capitalize!,
        onTap: () => print('add api class'),
      ),
    );
  }
}
