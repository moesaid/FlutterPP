import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildSingleProjectParkedAt extends StatelessWidget {
  const BuildSingleProjectParkedAt({
    super.key,
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
                  color:
                      Get.theme.colorScheme.onPrimaryContainer.withOpacity(0.7),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
