import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildDashboardEnvCheck extends StatelessWidget {
  const BuildDashboardEnvCheck({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.sp),
        color: Get.theme.colorScheme.primaryContainer,
        border: Border.all(
          width: 1,
          color: Get.theme.colorScheme.secondaryContainer,
        ),
      ),
      width: context.width * 0.3,
      height: context.height * 0.3,
    );
  }
}
