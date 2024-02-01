import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/project_single_controller.dart';
import 'package:flutterpp/App/Views/Global/build_appbar.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_single_project_header.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class ProjectSinglePage extends GetView<ProjectSingleController> {
  const ProjectSinglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleController>(
      init: ProjectSingleController(),
      initState: (_) {},
      builder: (_) {
        return Material(
          child: BuildLoadingOrEmptyLayout(
            isLoading: controller.isLoading,
            isEmpty: controller.project.id == null,
            hasButton: false,
            child: Scaffold(
              appBar: BuildAppBar(
                title: controller.project.title ?? '',
                hasBackButton: true,
                onBack: () => Get.back(),
              ),
              body: SafeArea(
                child: BuildProjectSinglePage(controller: controller),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BuildProjectSinglePage extends StatelessWidget {
  final ProjectSingleController controller;
  const BuildProjectSinglePage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildSingleProjectHeader(controller: controller),
        Expanded(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                controller.projectLocalPath.isEmpty
                    ? const SizedBox.shrink()
                    : TabBar(
                        dividerColor: Get.theme.colorScheme.secondaryContainer,
                        indicatorColor: Get.theme.primaryColorLight,
                        labelColor: Get.theme.primaryColorLight,
                        unselectedLabelColor:
                            Get.theme.colorScheme.onBackground,
                        indicatorSize: TabBarIndicatorSize.label,
                        isScrollable: true,
                        enableFeedback: true,
                        tabs: [
                          Tab(text: 'Code Gen'.capitalize!),
                          Tab(text: 'docs'.capitalize!),
                          Tab(text: 'ci / cd'.capitalize!),
                        ],
                      ),
                Expanded(
                  child: controller.projectLocalPath.isEmpty
                      ? const BuildSingleProjectNoPathState()
                      : const TabBarView(
                          children: [
                            Center(child: Text('Tasks')),
                            Center(child: Text('Tasks')),
                            Center(child: Text('Members')),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BuildSingleProjectNoPathState extends StatelessWidget {
  const BuildSingleProjectNoPathState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/lottie/empty_box.json',
          height: 200,
          width: 200,
        ),
        SizedBox(height: 2.sp),
        Text(
          'No local path found - your code\'s gone on a cosmic vacation! 🚀🤷',
          style: Get.textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 1.sp),
        Text(
          'create a new project or load an existing one',
          style: Get.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
