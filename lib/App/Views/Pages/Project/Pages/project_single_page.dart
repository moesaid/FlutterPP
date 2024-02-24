import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_controller.dart';
import 'package:flutterpp/App/Views/Global/build_appbar.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_single_project_header.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_single_project_no_path_state.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_single_project_start_config.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_single_project_tab_view.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_single_project_tap_header.dart';
import 'package:get/get.dart';

class ProjectSinglePage extends GetView<ProjectSingleController> {
  final String? projectId;
  final bool? hasAppBar;
  const ProjectSinglePage({
    super.key,
    this.projectId,
    this.hasAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleController>(
      init: ProjectSingleController(),
      didChangeDependencies: (state) {
        String? id = projectId ?? Get.parameters['projectId'];
        state.controller?.fetchApi(projectId: id);
      },
      initState: (_) {},
      builder: (_) {
        return Material(
          child: BuildLoadingOrEmptyLayout(
            isLoading: controller.isLoading,
            isEmpty: controller.project.id == null,
            title: 'no active project found',
            hasButton: false,
            child: Scaffold(
              appBar: hasAppBar == true
                  ? BuildAppBar(
                      title: _.project.title ?? '',
                      hasBackButton: true,
                      onBack: () => Get.back(),
                    )
                  : null,
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
            length: 4,
            child: Obx(
              () => Column(
                children: [
                  controller.projectLocalPath.isEmpty ||
                          !controller.isFlutterPPProject
                      ? const SizedBox.shrink()
                      : const BuildSingleProjectTapHeader(),
                  Expanded(
                    child: controller.projectLocalPath.isEmpty
                        ? const BuildSingleProjectNoPathState()
                        : !controller.isFlutterPPProject
                            ? const BuildSingleProjectStartConfig()
                            : BuildSingleProjectTabView(controller: controller),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
