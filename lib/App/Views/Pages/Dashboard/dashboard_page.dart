import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Dashboard/dashboard_controller.dart';
import 'package:flutterpp/App/Controllers/Global/app_update_controller.dart';
import 'package:flutterpp/App/Views/Global/build_loading_switch.dart';
import 'package:flutterpp/App/Views/Pages/Dashboard/Sections/build_dashboard_project_section.dart';
import 'package:flutterpp/App/Views/Pages/Dashboard/Widgets/build_dashboard_env_check.dart';
import 'package:flutterpp/App/Views/Pages/Dashboard/Widgets/build_dashboard_numbers_item.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
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
                    BuildDashboardChartSection(
                      projectsCount: controller.projects.length,
                      teamsCount: controller.teamMembers.length,
                      clientsCount: controller.clients.length,
                      invoicesCount: controller.invoices.length,
                    ),
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
  final int? projectsCount, clientsCount, invoicesCount, teamsCount;
  const BuildDashboardChartSection({
    this.projectsCount,
    this.clientsCount,
    this.invoicesCount,
    this.teamsCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BuildDashboardEnvCheck(),
        SizedBox(width: 5.sp),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  const BuildDashboardVersionDisplay(),
                  SizedBox(width: 5.sp),
                  Expanded(
                    child: Container(
                      height: context.height * 0.23,
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(3.sp),
                        border: Border.all(
                          width: 1,
                          color: Get.theme.colorScheme.secondaryContainer,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.sp),
              SizedBox(
                height: context.height * 0.15,
                child: GridView(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 5.sp,
                    mainAxisSpacing: 5.sp,
                    mainAxisExtent: context.height * 0.15,
                  ),
                  children: [
                    BuildDashboardNumbersItem(
                      title: 'count',
                      subtitle: 'Projects',
                      numbers: projectsCount,
                      icon: HeroIcons.bolt,
                      bgColor: Colors.indigo,
                    ),
                    BuildDashboardNumbersItem(
                      title: 'count',
                      subtitle: 'team members',
                      numbers: teamsCount,
                      icon: HeroIcons.users,
                      bgColor: Colors.purple,
                    ),
                    BuildDashboardNumbersItem(
                      title: 'count',
                      subtitle: 'clients',
                      numbers: clientsCount,
                      icon: HeroIcons.briefcase,
                      bgColor: Colors.green,
                    ),
                    BuildDashboardNumbersItem(
                      title: 'count',
                      subtitle: 'invoices',
                      numbers: invoicesCount,
                      icon: HeroIcons.currencyDollar,
                      bgColor: Colors.orange,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

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
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 1.sp),
                      Text(
                        _.currentVersion,
                        style: TextStyle(
                          fontSize: 4.sp,
                          fontWeight: FontWeight.w300,
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
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 1.sp),
                      Text(
                        _.lastVersion,
                        style: TextStyle(
                          fontSize: 4.sp,
                          fontWeight: FontWeight.w300,
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
