import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/project_single_controller.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_project_avatar.dart';
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
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'parked at'.capitalize!,
                style: Get.textTheme.labelSmall,
              ),
              SizedBox(height: 1.sp),
              Container(
                padding: EdgeInsets.all(2.sp),
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(2.sp),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.folder,
                      size: 4.sp,
                      color: Get.theme.colorScheme.onPrimaryContainer,
                    ),
                    const Text(' :: '),
                    SizedBox(width: 1.sp),
                    Text(
                      '/Users/mohamedsaid/development/flutter_workshop/Apps/flutterpp',
                      style: Get.textTheme.bodySmall!.copyWith(
                        color: Get.theme.colorScheme.onPrimaryContainer
                            .withOpacity(0.7),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
