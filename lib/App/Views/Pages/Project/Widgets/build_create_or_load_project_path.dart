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
            color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
            size: 6.spa,
          ),
          label: const Text('Create'),
          style: TextButton.styleFrom(
            foregroundColor: Get.theme.colorScheme.onSurface,
            backgroundColor: Get.theme.colorScheme.secondaryContainer,
            visualDensity: VisualDensity.compact,
          ),
        ),
        SizedBox(width: 4.spa),
        const Text(' - or - '),
        SizedBox(width: 4.spa),
        TextButton.icon(
          onPressed: onLoad,
          icon: Icon(
            Icons.folder,
            color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
            size: 6.spa,
          ),
          label: const Text('Load'),
          style: TextButton.styleFrom(
            foregroundColor: Get.theme.colorScheme.onSurface,
            backgroundColor: Get.theme.colorScheme.secondaryContainer,
            visualDensity: VisualDensity.compact,
          ),
        ),
      ],
    );
  }
}
