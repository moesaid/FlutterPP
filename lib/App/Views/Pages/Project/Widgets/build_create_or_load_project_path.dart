import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildCreateOrLoadProjectPath extends StatelessWidget {
  final VoidCallback? onCreate, onLoad;

  const BuildCreateOrLoadProjectPath({
    super.key,
    this.onCreate,
    this.onLoad,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          onPressed: onCreate,
          icon: Icon(
            Icons.add_circle_sharp,
            size: 6.sp,
          ),
          label: const Text('Create'),
          style: TextButton.styleFrom(
            foregroundColor: Get.theme.colorScheme.onBackground,
            backgroundColor: Get.theme.colorScheme.secondaryContainer,
            visualDensity: VisualDensity.compact,
          ),
        ),
        SizedBox(width: 4.sp),
        const Text(' - or - '),
        SizedBox(width: 4.sp),
        TextButton.icon(
          onPressed: onLoad,
          icon: Icon(
            Icons.folder,
            size: 6.sp,
          ),
          label: const Text('Load'),
          style: TextButton.styleFrom(
            foregroundColor: Get.theme.colorScheme.onBackground,
            backgroundColor: Get.theme.colorScheme.secondaryContainer,
            visualDensity: VisualDensity.compact,
          ),
        ),
      ],
    );
  }
}
