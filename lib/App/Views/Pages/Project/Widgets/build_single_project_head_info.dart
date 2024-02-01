import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/project_single_controller.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_project_avatar.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildSingleProjectHeadInfo extends StatelessWidget {
  const BuildSingleProjectHeadInfo({
    super.key,
    required this.controller,
  });

  final ProjectSingleController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BuildProjectAvatar(
          icon: controller.project.icon ?? '',
          colors: [
            ColorHelper.hexToColor(controller.project.color1 ?? '#000000'),
            ColorHelper.hexToColor(controller.project.color2 ?? '#000000'),
          ],
        ),
        SizedBox(width: 6.sp),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  controller.project.title ?? '',
                  style: Get.textTheme.titleLarge,
                ),
                IconButton.filledTonal(
                  onPressed: () => print('object'),
                  style: ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    iconColor: MaterialStateProperty.all(
                      Get.theme.colorScheme.onPrimaryContainer,
                    ),
                    iconSize: MaterialStateProperty.all(5.sp),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.transparent,
                    ),
                  ),
                  icon: const Icon(
                    Icons.edit,
                  ),
                ),
              ],
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
    );
  }
}
