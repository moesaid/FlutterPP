import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/project_single_controller.dart';
import 'package:flutterpp/App/Views/Global/build_appbar.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_project_avatar.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:get/get.dart';
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
        Container(
          width: context.width,
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorHelper.hexToColor(controller.project.color1 ?? '#000000')
                    .withOpacity(0.1),
                ColorHelper.hexToColor(controller.project.color2 ?? '#000000')
                    .withOpacity(0.06),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            color: Get.theme.colorScheme.secondaryContainer,
            border: Border(
              bottom: BorderSide(
                color: Get.theme.colorScheme.secondaryContainer,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              BuildProjectAvatar(
                icon: controller.project.icon ?? '',
                colors: [
                  ColorHelper.hexToColor(
                      controller.project.color1 ?? '#000000'),
                  ColorHelper.hexToColor(
                      controller.project.color2 ?? '#000000'),
                ],
              ),
              SizedBox(width: 6.sp),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.project.title ?? '',
                    style: Get.textTheme.titleLarge,
                  ),
                  SizedBox(height: 1.sp),
                  Text(
                    controller.project.description ?? '',
                    style: Get.textTheme.bodyMedium,
                  ),
                  SizedBox(height: 1.sp),
                ],
              ),
            ],
          ),
        ),
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
                  tabs: const [
                    Tab(text: 'Board'),
                    Tab(text: 'Tasks'),
                    Tab(text: 'Members'),
                  ],
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      Center(child: Text('Board')),
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
