import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Dashboard/dashboard_env_check_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildDashboardEnvCheck extends GetView<DashboardEnvCheckController> {
  const BuildDashboardEnvCheck({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardEnvCheckController>(
      init: DashboardEnvCheckController(),
      builder: (_) {
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
          child: Center(
            child: ElevatedButton(
              onPressed: () => controller.checkEnv(),
              child: const Text('Check Env'),
            ),
          ),
        );
      },
    );
  }
}
