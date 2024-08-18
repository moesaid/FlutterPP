import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Dashboard/dashboard_env_check_controller.dart';
import 'package:flutterpp/App/Views/Global/build_loading_switch.dart';
import 'package:get/get.dart';
import 'package:glowy_borders/glowy_borders.dart';
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
        return Obx(
          () => AnimatedGradientBorder(
            glowSize: 0,
            borderSize: 1,
            animationProgress:
                _.isLoading || _.checkEnvModel.dartInstalled != null
                    ? 0.8
                    : null,
            borderRadius: BorderRadius.circular(5),
            gradientColors: [Colors.transparent, Get.theme.colorScheme.primary],
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 4.spa,
                vertical: controller.checkEnvModel.dartInstalled != null
                    ? 4.sp
                    : 2.spa,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Get.theme.colorScheme.primaryContainer,
              ),
              width: context.width * 0.3,
              height: context.height * 0.4,
              child: BuildLoadingSwitch(
                isLoading: controller.isLoading,
                child: controller.checkEnvModel.dartInstalled == null
                    ? BuildEnvCheckEmptyState(controller: controller)
                    : BuildEnvCheckDataState(controller: controller),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BuildEnvCheckEmptyState extends StatelessWidget {
  const BuildEnvCheckEmptyState({
    super.key,
    required this.controller,
  });

  final DashboardEnvCheckController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Flutter Health Check',
          style: Get.textTheme.titleLarge,
        ),
        SizedBox(height: 2.spa),
        Text(
          'Let\'s Peek at Your Setup: Making Sure Your Dev Playground Is a Code Carnival!',
          textAlign: TextAlign.center,
          style: Get.textTheme.bodySmall,
        ),
        SizedBox(height: 8.spa),
        ElevatedButton(
          onPressed: () => controller.recheckEnv(),
          onHover: (value) => controller.updateIsHovring(value),
          child: Text(
            'let\'s go'.toUpperCase(),
            style: Get.textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}

class BuildEnvCheckDataState extends StatelessWidget {
  const BuildEnvCheckDataState({
    super.key,
    required this.controller,
  });

  final DashboardEnvCheckController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.deviceName.isNotEmpty
                      ? controller.deviceName
                      : 'Health Check',
                  style: Get.textTheme.titleMedium,
                ),
                if (controller.deviceModel.isNotEmpty)
                  Text(
                    controller.deviceModel,
                    style: Get.textTheme.bodySmall,
                  ),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () => controller.recheckEnv(),
              icon: const Icon(Icons.refresh),
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
            ),
          ],
        ),
        const Divider(thickness: 0.2, height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 6.spa,
                  vertical: 3.spa,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Get.theme.colorScheme.secondaryContainer,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'flutter installed'.capitalize!,
                            style: Get.textTheme.titleSmall?.copyWith(
                              fontSize: 5.spa,
                            ),
                          ),
                        ),
                        SizedBox(width: 2.spa),
                        Icon(
                          size: 7.spa,
                          controller.checkEnvModel.flutterInstalled == true
                              ? Icons.check_circle
                              : Icons.cancel,
                          color:
                              controller.checkEnvModel.flutterInstalled == true
                                  ? Colors.green
                                  : Colors.red,
                        ),
                      ],
                    ),
                    if (controller.checkEnvModel.flutterVersion != null)
                      SizedBox(height: 2.spa),
                    if (controller.checkEnvModel.flutterVersion != null)
                      Text(
                        'flutter version: ${controller.checkEnvModel.flutterVersion}'
                            .capitalize!,
                        style: Get.textTheme.bodySmall?.copyWith(
                          fontSize: 4.spa,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 4.spa),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 6.spa,
                  vertical: 3.spa,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Get.theme.colorScheme.secondaryContainer,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'dart installed'.capitalize!,
                            style: Get.textTheme.titleSmall?.copyWith(
                              fontSize: 5.spa,
                            ),
                          ),
                        ),
                        SizedBox(width: 2.spa),
                        Icon(
                          size: 7.spa,
                          controller.checkEnvModel.dartInstalled!
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: controller.checkEnvModel.dartInstalled!
                              ? Colors.green
                              : Colors.red,
                        ),
                      ],
                    ),
                    if (controller.checkEnvModel.dartVersion != null)
                      SizedBox(height: 2.spa),
                    if (controller.checkEnvModel.dartVersion != null)
                      Text(
                        'dart version: ${controller.checkEnvModel.dartVersion}'
                            .capitalize!,
                        style: Get.textTheme.bodySmall?.copyWith(
                          fontSize: 4.spa,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (controller.checkEnvModel.flutterDoctor != null)
          const Divider(thickness: 0.2, height: 30),
        if (controller.checkEnvModel.flutterDoctor != null)
          Expanded(
            child: ListView.builder(
              itemCount: controller.checkEnvModel.flutterDoctor!.length,
              itemBuilder: (_, int index) {
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  title: Text(
                    controller.checkEnvModel.flutterDoctor![index].body!.trim(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.titleSmall!.copyWith(
                      fontSize: 4.9.spa,
                      color:
                          controller.checkEnvModel.flutterDoctor![index].head ==
                                  null
                              ? Colors.yellow.withOpacity(0.8)
                              : controller.checkEnvModel.flutterDoctor![index]
                                          .head ==
                                      true
                                  ? Colors.green.withOpacity(0.8)
                                  : Colors.red,
                    ),
                  ),
                  trailing: Icon(
                    size: 7.spa,
                    controller.checkEnvModel.flutterDoctor![index].head == null
                        ? Icons.warning_amber_rounded
                        : controller.checkEnvModel.flutterDoctor![index].head!
                            ? Icons.check_circle
                            : Icons.cancel,
                    color: controller
                                .checkEnvModel.flutterDoctor![index].head ==
                            null
                        ? Colors.yellow
                        : controller.checkEnvModel.flutterDoctor![index].head!
                            ? Colors.green
                            : Colors.red,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
