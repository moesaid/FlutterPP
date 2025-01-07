import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_files_controller.dart';
import 'package:flutterpp/App/Models/media_model.dart';
import 'package:flutterpp/App/Views/Global/build_custom_dropdown.dart';
import 'package:flutterpp/App/Views/Global/build_rename_dialog.dart';
import 'package:flutterpp/Helpers/int_helper.dart';
import 'package:flutterpp/Helpers/text_helper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
      padding: EdgeInsets.all(5.spa),
      separatorBuilder: (_, __) => SizedBox(height: 2.spa),
      itemBuilder: (_, int index) {
        MediaModel file = controller.searchResults.isNotEmpty
            ? controller.searchResults[index]
            : controller.files[index];
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: 4.spa,
            horizontal: 3.spa,
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
                size: 8.spa,
                color: Get.theme.colorScheme.secondary,
              ),
              SizedBox(width: 2.spa),
              Text(
                file.fileName ?? '',
                style: Get.textTheme.bodyMedium?.copyWith(
                  fontSize: 4.5.spa,
                ),
              ),
              const Spacer(),
              Text(
                file.size?.toFileSize() ?? '',
                style: Get.textTheme.bodyMedium?.copyWith(
                  fontSize: 5.spa,
                  color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
              SizedBox(width: 2.spa),
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
                            controller.renameMedia(file, value);
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
