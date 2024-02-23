import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Dashboard/dashboard_controller.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Views/Global/build_loading_switch.dart';
import 'package:flutterpp/App/Views/Pages/Dashboard/Sections/build_dashboard_project_section.dart';
import 'package:flutterpp/App/Views/Pages/Dashboard/Widgets/build_dashboard_chart.dart';
import 'package:flutterpp/App/Views/Pages/Dashboard/Widgets/build_dashboard_env_check.dart';
import 'package:flutterpp/App/Views/Pages/Dashboard/Widgets/build_dashboard_numbers_item.dart';
import 'package:flutterpp/App/Views/Pages/Dashboard/Widgets/build_dashboard_version_display.dart';
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
                padding: EdgeInsets.only(
                  left: 5.sp,
                  right: 7.sp,
                  top: 5.sp,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hey ${controller.profile.fullName ?? ''} 🖐️'
                          .capitalize!,
                      style: TextStyle(
                        fontSize: context.width * 0.015,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 1.sp),
                    Text(
                      'welcome to the mysterious realm of limitless potential, where blank pages eagerly await your unique imprint. 🚀',
                      style: TextStyle(
                        fontSize: context.width * 0.013,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    BuildDashboardChartSection(
                      projectsCount: controller.projects.length,
                      teamsCount: controller.teamMembers.length,
                      clientsCount: controller.clients.length,
                      invoicesCount: controller.invoices.length,
                      invoices: controller.invoices,
                      onMorePressed: controller.navigateToInvoiceIndex,
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
  final List<InvoiceModel> invoices;
  final VoidCallback onMorePressed;
  const BuildDashboardChartSection({
    this.projectsCount,
    this.clientsCount,
    this.invoicesCount,
    this.teamsCount,
    required this.invoices,
    required this.onMorePressed,
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
                    child: BuildDashboardChart(
                      invoices: invoices,
                      onMorePressed: onMorePressed,
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
