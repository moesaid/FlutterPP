import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_files_controller.dart';
import 'package:flutterpp/App/Models/media_model.dart';
import 'package:flutterpp/App/Views/Global/build_custom_dropdown.dart';
import 'package:flutterpp/App/Views/Global/build_rename_dialog.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/Files/build_project_single_files_body.dart';
import 'package:flutterpp/Helpers/int_helper.dart';
import 'package:flutterpp/Helpers/text_helper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProjectSingleFilesPage extends GetView<ProjectSingleFilesController> {
  const ProjectSingleFilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleFilesController>(
      init: ProjectSingleFilesController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                BuildProjectSingleFilesBody(controller: controller),
                BuildProjectSingleFilesSidebar(controller: controller),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BuildProjectSingleFilesList extends StatelessWidget {
  const BuildProjectSingleFilesList({
    super.key,
    required this.controller,
  });

  final ProjectSingleFilesController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: controller.searchResults.isNotEmpty
          ? controller.searchResults.length
          : controller.files.length,
      padding: EdgeInsets.all(5.sp),
      separatorBuilder: (_, __) => SizedBox(height: 2.sp),
      itemBuilder: (_, int index) {
        MediaModel file = controller.searchResults.isNotEmpty
            ? controller.searchResults[index]
            : controller.files[index];
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: 4.sp,
            horizontal: 3.sp,
          ),
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                file.type?.getIcon() ?? 'default'.getIcon(),
                size: 8.sp,
                color: Get.theme.colorScheme.secondary,
              ),
              SizedBox(width: 2.sp),
              Text(
                file.fileName ?? '',
                style: Get.textTheme.bodyMedium?.copyWith(
                  fontSize: 4.5.sp,
                ),
              ),
              const Spacer(),
              Text(
                file.size?.toFileSize() ?? '',
                style: Get.textTheme.bodyMedium?.copyWith(
                  fontSize: 5.sp,
                  color: Get.theme.colorScheme.onBackground.withOpacity(0.4),
                ),
              ),
              SizedBox(width: 2.sp),
              BuildCustomDropdown(
                items: [
                  PopupMenuItem(
                    child: const Text('Download'),
                    onTap: () => controller.downloadFile(file),
                  ),
                  PopupMenuItem(
                    child: const Text('rename'),
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) {
                        return BuildRenameDialog(
                          title: file.fileName ?? '',
                          callback: (value) {
                            controller.renameMedia(file.id, value);
                          },
                        );
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: const Text('Delete'),
                    onTap: () => controller.removeMedia(file.id, file.path),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

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
        padding: EdgeInsets.all(5.sp),
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
                    padding: EdgeInsets.all(2.sp),
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
                            fontSize: 10.sp,
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
                              color: Get.theme.colorScheme.onBackground
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
                              color: Get.theme.colorScheme.onBackground
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
                SizedBox(height: 2.sp),
                BuildProjectSingleFilesTypeWithSize(
                  icon: Icons.upload_file_rounded,
                  color: Colors.blueAccent,
                  title: 'documents',
                  size: controller.documentsSize.toFileSize(),
                ),
                SizedBox(height: 2.sp),
                BuildProjectSingleFilesTypeWithSize(
                  icon: Icons.folder_zip_rounded,
                  color: Colors.redAccent,
                  title: 'compressed',
                  size: controller.compressedSize.toFileSize(),
                ),
                SizedBox(height: 2.sp),
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
