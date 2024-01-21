import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/dashboard_controller.dart';
import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Views/Global/build_loading_switch.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_project_avatar.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
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
                padding: EdgeInsets.all(4.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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

class BuildDashboardProjectSection extends StatelessWidget {
  const BuildDashboardProjectSection({
    super.key,
    required this.controller,
  });

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('projects'.capitalize!),
        SizedBox(height: 3.sp),
        Row(
          children: [
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.sp),
                border: Border.all(
                  width: 1,
                  color: Colors.grey.shade900,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.add, size: 50),
                  SizedBox(height: 1.sp),
                  Text(
                    'create new project'.capitalize!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 4.sp,
                      // fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 5.sp),
            Expanded(
              child: SizedBox(
                height: 180,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.projects.length,
                  separatorBuilder: (context, index) => SizedBox(
                    width: 5.sp,
                  ),
                  itemBuilder: (context, index) {
                    ProjectModel item = controller.projects[index];
                    return Container(
                      width: 180,
                      height: 180,
                      padding: EdgeInsets.all(5.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.sp),
                        border: Border.all(
                          width: 1,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BuildProjectAvatar(
                            colors: [
                              ColorHelper.hexToColor(item.color1!),
                              ColorHelper.hexToColor(item.color2!)
                            ],
                            icon: item.icon!,
                          ),
                          SizedBox(height: 2.sp),
                          Text(
                            item.title?.capitalize ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 5.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 1.sp),
                          Text(
                            item.description ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 3.6.sp,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
