import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutterpp/App/Controllers/Global/app_update_controller.dart';
import 'package:flutterpp/App/Views/Global/build_loading_switch.dart';
import 'package:flutterpp/App/Views/Global/buiuld_dialog.dart';
import 'package:get/get.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sizer/sizer.dart';

class BuildDashboardVersionDisplay extends StatelessWidget {
  const BuildDashboardVersionDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppUpdateController>(
      init: AppUpdateController(),
      initState: (_) {},
      builder: (_) {
        return BuildDashboardVersionDesplayView(controller: _);
      },
    );
  }
}

class BuildDashboardVersionDesplayView extends StatelessWidget {
  final AppUpdateController controller;
  const BuildDashboardVersionDesplayView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final _ = controller;
    return Container(
      height: context.height * 0.23,
      width: context.width * 0.1,
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(3.sp),
        border: Border.all(
          width: 1,
          color: Get.theme.colorScheme.secondaryContainer,
        ),
      ),
      child: BuildLoadingSwitch(
        isLoading: _.isLoading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'current version'.capitalize!,
                    style: TextStyle(
                      fontSize: context.width * 0.01,
                      color: Get.theme.colorScheme.onPrimary.withOpacity(
                        0.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.sp),
                  Text(
                    _.currentVersion,
                    style: TextStyle(
                      fontSize: context.width * 0.013,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 0.5, height: 0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'latest version'.capitalize!,
                    style: TextStyle(
                      fontSize: context.width * 0.01,
                      color: Get.theme.colorScheme.onPrimary.withOpacity(
                        0.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.sp),
                  Tooltip(
                    message: 'view changelog',
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (__) {
                            return BuildDashboardVersionDisplayDialog(
                              controller: _,
                            );
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _.lastVersion,
                            style: TextStyle(
                              fontSize: context.width * 0.013,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 2.sp),
                          AnimatedGradientBorder(
                            borderSize: 1,
                            glowSize: 0,
                            gradientColors: [
                              Get.theme.colorScheme.secondary,
                              Get.theme.colorScheme.secondaryContainer,
                              Get.theme.colorScheme.secondary,
                              Get.theme.colorScheme.primaryContainer,
                            ],
                            borderRadius: BorderRadius.circular(100),
                            child: Icon(
                              Icons.info_rounded,
                              size: context.width * 0.013,
                              color: Get.theme.colorScheme.onBackground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildDashboardVersionDisplayDialog extends StatelessWidget {
  final AppUpdateController controller;
  const BuildDashboardVersionDisplayDialog({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BuildDefultDialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Markdown(
              data: controller.body,
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(
                  fontSize: context.width * 0.01,
                  color: Get.theme.colorScheme.onPrimary.withOpacity(0.5),
                ),
                h1: TextStyle(
                  fontSize: context.width * 0.013,
                  fontWeight: FontWeight.w500,
                ),
                h2: TextStyle(
                  fontSize: context.width * 0.013,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTapLink: (text, href, title) async {
                if (href == null) return;
                controller.openUrl(href);
              },
            ),
          ),
          SizedBox(height: context.height * 0.02),
          ElevatedButton.icon(
            onPressed: () {
              if (controller.url.isEmpty) return;
              controller.openUrl(controller.url);
            },
            icon: HeroIcon(
              HeroIcons.link,
              size: 6.sp,
            ),
            label: const Text('open release page'),
          ),
        ],
      ),
    );
  }
}
