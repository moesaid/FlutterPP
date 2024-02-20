import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Global/app_update_controller.dart';
import 'package:flutterpp/App/Views/Global/build_loading_switch.dart';
import 'package:get/get.dart';
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
                          fontSize: 4.sp,
                          color: Get.theme.colorScheme.onPrimary.withOpacity(
                            0.5,
                          ),
                        ),
                      ),
                      SizedBox(height: 1.sp),
                      Text(
                        _.currentVersion,
                        style: TextStyle(
                          fontSize: 5.sp,
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
                          fontSize: 4.sp,
                          color: Get.theme.colorScheme.onPrimary.withOpacity(
                            0.5,
                          ),
                        ),
                      ),
                      SizedBox(height: 1.sp),
                      Text(
                        _.lastVersion,
                        style: TextStyle(
                          fontSize: 5.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
