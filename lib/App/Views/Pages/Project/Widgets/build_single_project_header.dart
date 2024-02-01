import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/project_single_controller.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_create_or_load_project_path.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_single_project_head_info.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_single_project_parked_at.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildSingleProjectHeader extends StatelessWidget {
  const BuildSingleProjectHeader({
    super.key,
    required this.controller,
  });

  final ProjectSingleController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          BuildSingleProjectHeadInfo(controller: controller),
          const Spacer(),
          if (controller.projectLocalPath.isNotEmpty)
            BuildSingleProjectParkedAt(path: controller.projectLocalPath),
          if (controller.projectLocalPath.isEmpty)
            const BuildCreateOrLoadProjectPath(),
        ],
      ),
    );
  }
}
