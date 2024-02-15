import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Dashboard/dashboard_controller.dart';
import 'package:flutterpp/App/Views/Global/build_loading_switch.dart';
import 'package:flutterpp/App/Views/Pages/Dashboard/Sections/build_dashboard_project_section.dart';
import 'package:flutterpp/App/Views/Pages/Dashboard/Widgets/build_dashboard_env_check.dart';
import 'package:flutterpp/App/Views/Pages/Dashboard/Widgets/build_dashboard_numbers_item.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: BuildLoadingSwitch(
              isLoading: controller.isLoading,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(5.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hey ${controller.profile.fullName ?? ''} 🖐️'
                          .capitalize!,
                      style: TextStyle(
                        fontSize: 6.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 1.sp),
                    Text(
                      'welcome to the mysterious realm of limitless potential, where blank pages eagerly await your unique imprint. 🚀',
                      style: TextStyle(
                        fontSize: 5.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    const BuildDashboardChartSection(),
                    SizedBox(height: 10.sp),
                    BuildDashboardProjectSection(controller: controller),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BuildDashboardChartSection extends StatelessWidget {
  const BuildDashboardChartSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BuildDashboardEnvCheck(),
        SizedBox(width: 5.sp),
        Expanded(
          child: SizedBox(
            height: 60.sp,
            child: GridView(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 5.sp,
                mainAxisSpacing: 5.sp,
                mainAxisExtent: 60.sp,
              ),
              children: const [
                BuildDashboardNumbersItem(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
