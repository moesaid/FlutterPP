import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/project_single_controller.dart';
import 'package:flutterpp/App/Views/Global/build_appbar.dart';
import 'package:flutterpp/App/Views/Global/build_loading_switch.dart';
import 'package:get/get.dart';

class ProjectSinglePage extends GetView<ProjectSingleController> {
  const ProjectSinglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleController>(
      init: ProjectSingleController(),
      initState: (_) {},
      builder: (_) {
        return Material(
          child: BuildLoadingSwitch(
            isLoading: controller.isLoading,
            child: Scaffold(
              appBar: BuildAppBar(
                title: controller.project.title ?? '',
                hasBackButton: true,
                onBack: () => Get.back(),
              ),
              body: BuildLoadingSwitch(
                isLoading: controller.isLoading,
                child: SafeArea(
                  child: controller.project.id == null ||
                          controller.project.id!.isEmpty
                      ? const BuildProjectSingleEmptyState()
                      : const BuildProjectSinglePage(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BuildProjectSinglePage extends StatelessWidget {
  const BuildProjectSinglePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('data');
  }
}

class BuildProjectSingleEmptyState extends StatelessWidget {
  const BuildProjectSingleEmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('empty');
  }
}
