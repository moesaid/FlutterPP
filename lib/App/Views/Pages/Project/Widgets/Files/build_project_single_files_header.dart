import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_files_controller.dart';
import 'package:flutterpp/App/Views/Global/build_search_form.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
