import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_files_controller.dart';
import 'package:flutterpp/App/Models/media_model.dart';
import 'package:flutterpp/App/Views/Global/build_custom_dropdown.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:flutterpp/App/Views/Global/build_rename_dialog.dart';
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

class BuildProjectSingleFilesBody extends StatelessWidget {
  const BuildProjectSingleFilesBody({
    super.key,
    required this.controller,
  });

  final ProjectSingleFilesController controller;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: Column(
        children: [
          BuildProjectSingleFilesHeader(controller: controller),
          Expanded(
            child: BuildLoadingOrEmptyLayout(
              isLoading: controller.isLoading,
              isEmpty: controller.files.isEmpty,
              title: 'No Files Found'.capitalize!,
              child: BuildProjectSingleFilesList(
                controller: controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildProjectSingleFilesHeader extends StatelessWidget {
  const BuildProjectSingleFilesHeader({
    super.key,
    required this.controller,
  });

  final ProjectSingleFilesController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.sp),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Get.theme.colorScheme.primaryContainer,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            'Files'.capitalize!,
            style: Get.textTheme.titleLarge,
          ),
          const Spacer(),
          BuildSearchForm(
            searchKey: controller.searchKey,
            onSearch: controller.searchFiles,
            onClear: controller.clearSearch,
          ),
          SizedBox(width: 5.sp),
          FilledButton.icon(
            onPressed: () => controller.uploadFile(),
            icon: const Icon(Icons.cloud_upload_rounded),
            label: Text(
              'Upload'.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            style: FilledButton.styleFrom(
              padding: EdgeInsets.symmetric(
                vertical: 5.sp,
                horizontal: 6.sp,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
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

class BuildSearchForm extends StatelessWidget {
  final void Function(String)? onSearch;
  final void Function()? onClear;
  final String? searchKey;
  const BuildSearchForm({
    super.key,
    this.onSearch,
    this.searchKey,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formKey,
      child: Container(
        width: context.width * 0.2,
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.symmetric(
          horizontal: 4.sp,
          vertical: 2.sp,
        ),
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FormBuilderTextField(
                name: 'name',
                initialValue: searchKey,
                scrollPadding: EdgeInsets.zero,
                cursorHeight: 15,
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 2.sp,
                    horizontal: 0,
                  ),
                  isDense: true,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  hintStyle: Get.textTheme.bodyMedium?.copyWith(
                    color: Get.theme.colorScheme.onBackground.withOpacity(0.4),
                  ),
                ),
              ),
            ),
            SizedBox(width: 2.sp),
            InkWell(
              onTap: () {
                if (searchKey != null && searchKey!.isNotEmpty) {
                  onClear?.call();
                  return;
                }

                if (formKey.currentState?.saveAndValidate() == true) {
                  onSearch?.call(formKey.currentState?.value['name']);
                }
              },
              child: Icon(
                (searchKey != null && searchKey!.isNotEmpty)
                    ? Icons.close
                    : Icons.search_rounded,
                size: 6.sp,
              ),
            ),
          ],
        ),
      ),
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

class BuildProjectSingleFilesTypeWithSize extends StatelessWidget {
  final Color? color;
  final IconData? icon;
  final String? title, size;
  const BuildProjectSingleFilesTypeWithSize({
    super.key,
    this.color,
    this.icon,
    this.title,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 2.sp,
        horizontal: 4.sp,
      ),
      decoration: BoxDecoration(
        color:
            color?.withOpacity(0.07) ?? Get.theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon ?? Icons.folder,
            size: 5.sp,
            color: color,
          ),
          SizedBox(width: 2.sp),
          Text(
            title?.capitalize ?? 'Files',
            style: TextStyle(color: color),
          ),
          const Spacer(),
          Text(
            size ?? '',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
