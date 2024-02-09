import 'package:flutter/material.dart';
import 'package:flutterpp/App/Providers/Device/file_maneger_provider.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildSingleProjectParkedAt extends StatelessWidget {
  final String? path;
  const BuildSingleProjectParkedAt({
    super.key,
    this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'parked at'.capitalize!,
          style: Get.textTheme.labelSmall,
        ),
        SizedBox(height: 1.sp),
        InkWell(
          onTap: () {
            if (path == null) return;
            FileManegerProvider().openFolder(location: path!);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 1.sp,
              horizontal: 4.sp,
            ),
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
                  path ?? 'No path',
                  style: Get.textTheme.bodySmall!.copyWith(
                    color: Get.theme.colorScheme.onPrimaryContainer
                        .withOpacity(0.7),
                    fontStyle: FontStyle.italic,
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
