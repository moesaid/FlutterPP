import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/project_single_controller.dart';
import 'package:flutterpp/App/Services/Cmd/cmd_read_create_dir_services.dart';
import 'package:flutterpp/App/Views/Global/build_appbar.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_single_project_header.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_single_project_tab_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

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
            hasButton: false,
            child: Scaffold(
              appBar: hasAppBar == true
                  ? BuildAppBar(
                      title: controller.project.title ?? '',
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
            length: 3,
            child: Column(
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
      ],
    );
  }
}

class BuildSingleProjectStartConfig extends StatelessWidget {
  const BuildSingleProjectStartConfig({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/lottie/gears.json',
          height: 200,
          width: 200,
        ),
        Text(
          'This project is not a FlutterPP project.',
          style: Get.textTheme.titleLarge,
        ),
        SizedBox(height: 3.sp),
        const Text(
          'Code confusion alert! Our project seems lost in the tech wilderness. \n Ready to play detective and configure its identity?',
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.sp),
        ElevatedButton(
          onPressed: () {},
          child: Text(
            'start configuration'.capitalize!,
            style: Get.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class BuildSingleProjectTapHeader extends StatelessWidget {
  const BuildSingleProjectTapHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      dividerColor: Get.theme.colorScheme.secondaryContainer,
      indicatorColor: Get.theme.primaryColorLight,
      labelColor: Get.theme.primaryColorLight,
      unselectedLabelColor: Get.theme.colorScheme.onBackground,
      indicatorSize: TabBarIndicatorSize.label,
      isScrollable: true,
      enableFeedback: true,
      tabs: [
        Tab(text: 'Code Gen'.capitalize!),
        Tab(text: 'docs'.capitalize!),
        Tab(text: 'ci / cd'.capitalize!),
      ],
    );
  }
}

class BuildSingleProjectCodeGen extends StatelessWidget {
  final String? localPath;
  const BuildSingleProjectCodeGen({
    super.key,
    this.localPath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          var res = await CmdReadCreateDirServices().isFlutterPPProject(
            localPath!,
          );
          print(res);
        },
        child: const Text('Tasks'),
      ),
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
