import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/project_single_controller.dart';
import 'package:flutterpp/App/Models/project_local_path_model.dart';
import 'package:flutterpp/App/Views/Global/build_appbar.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_single_project_header.dart';
import 'package:flutterpp/Storage/projects_local_path_storage.dart';
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
                TabBar(
                  dividerColor: Get.theme.colorScheme.secondaryContainer,
                  indicatorColor: Get.theme.primaryColorLight,
                  labelColor: Get.theme.primaryColorLight,
                  unselectedLabelColor: Get.theme.colorScheme.onBackground,
                  indicatorSize: TabBarIndicatorSize.label,
                  // labelPadding: EdgeInsets.zero,
                  isScrollable: true,
                  tabs: [
                    Tab(text: 'Code Gen'.capitalize!),
                    Tab(text: 'docs'.capitalize!),
                    Tab(text: 'ci / cd'.capitalize!),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(ProjectsLocalPathStorage()
                                  .readById(
                                      projectId:
                                          '17509425-7d58-45ea-ae43-88ac449fa10f')!
                                  .path ??
                              ''),
                          Expanded(
                            child: ListView.builder(
                              itemCount:
                                  ProjectsLocalPathStorage().readAll().length,
                              itemBuilder: (BuildContext context, int index) {
                                ProjectLocalPathModel item =
                                    ProjectsLocalPathStorage().readAll()[index];
                                return Text(item.id!);
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          // ElevatedButton(
                          //   onPressed: () => controller.addLocalPath(),
                          //   child: const Text('Add Local Path'),
                          // ),
                        ],
                      ),
                      const Center(child: Text('Tasks')),
                      const Center(child: Text('Members')),
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
