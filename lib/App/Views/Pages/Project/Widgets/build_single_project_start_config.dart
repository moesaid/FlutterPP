import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_config_controller.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class BuildSingleProjectStartConfig
    extends GetView<ProjectSingleConfigController> {
  const BuildSingleProjectStartConfig({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleConfigController>(
        init: ProjectSingleConfigController(),
        builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lottie/gears.json',
                height: 200,
                width: 200,
              ),
              Text(
                'This project is not a FlutterPP project.',
                style: Get.textTheme.titleLarge,
              ),
              SizedBox(height: 3.sp),
              const Text(
                'Code confusion alert! Our project seems lost in the tech wilderness. \n Ready to play detective and configure its identity?',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.sp),
              ElevatedButton(
                onPressed: () => controller.startConfig(),
                child: Text(
                  'start configuration'.capitalize!,
                  style: Get.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
