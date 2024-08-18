import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_files_controller.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/Files/build_project_single_files_type_with_size.dart';
import 'package:flutterpp/Helpers/int_helper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildProjectSingleFilesSidebar extends StatelessWidget {
  const BuildProjectSingleFilesSidebar({
    super.key,
    required this.controller,
  });

  final ProjectSingleFilesController controller;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        padding: EdgeInsets.all(5.spa),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Get.theme.colorScheme.primaryContainer,
              width: 1,
            ),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    padding: EdgeInsets.all(2.spa),
                    width: context.width * 0.18,
                    child: DashedCircularProgressBar.aspectRatio(
                      aspectRatio: 1,
                      progress: controller.usedPercentage,
                      startAngle: 225,
                      sweepAngle: 270,
                      foregroundColor: Get.theme.colorScheme.secondary,
                      backgroundColor: Get.theme.colorScheme.primaryContainer,
                      foregroundStrokeWidth: 15,
                      backgroundStrokeWidth: 15,
                      animation: true,
                      seekSize: 0,
                      seekColor: const Color(0xffeeeeee),
                      child: Center(
                        child: Text(
                          controller.usedPercentage == 0
                              ? '0%'
                              : '${controller.usedPercentage.toStringAsFixed(2)}%',
                          style: TextStyle(
                            fontSize: 10.spa,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'used Storage'.capitalize!,
                            style: Get.textTheme.bodyMedium?.copyWith(
                              color: Get.theme.colorScheme.onSurface
                                  .withOpacity(0.4),
                            ),
                          ),
                          Text(
                            controller.usedSize.toFileSize(),
                            style: Get.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'total Storage'.capitalize!,
                            style: Get.textTheme.bodyMedium?.copyWith(
                              color: Get.theme.colorScheme.onSurface
                                  .withOpacity(0.4),
                            ),
                          ),
                          Text(
                            controller.totalSize.toFileSize(),
                            style: Get.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: [
                BuildProjectSingleFilesTypeWithSize(
                  icon: Icons.image_rounded,
                  color: Colors.greenAccent,
                  title: 'media',
                  size: controller.mediaSize.toFileSize(),
                ),
                SizedBox(height: 2.spa),
                BuildProjectSingleFilesTypeWithSize(
                  icon: Icons.upload_file_rounded,
                  color: Colors.blueAccent,
                  title: 'documents',
                  size: controller.documentsSize.toFileSize(),
                ),
                SizedBox(height: 2.spa),
                BuildProjectSingleFilesTypeWithSize(
                  icon: Icons.folder_zip_rounded,
                  color: Colors.redAccent,
                  title: 'compressed',
                  size: controller.compressedSize.toFileSize(),
                ),
                SizedBox(height: 2.spa),
                BuildProjectSingleFilesTypeWithSize(
                  icon: Icons.follow_the_signs_rounded,
                  color: Colors.orangeAccent,
                  title: 'others',
                  size: controller.otherSize.toFileSize(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
