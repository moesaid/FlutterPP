import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildDashboardNumbersItem extends StatelessWidget {
  const BuildDashboardNumbersItem({
    super.key,
    required this.controller,
  });

  final DashboardController controller;

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'team members'.capitalize!,
                        style: TextStyle(
                          fontSize: 4.sp,
                          fontWeight: FontWeight.w400,
                          color: Get.theme.colorScheme.onBackground.withOpacity(
                            0.3,
                          ),
                        ),
                      ),
                      Text(
                        controller.teamMembers.length.toString(),
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(1.sp),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.indigo,
                    ),
                    child: Icon(
                      Icons.supervised_user_circle_rounded,
                      size: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(thickness: 0.5, height: 0),
          Padding(
            padding: EdgeInsets.all(1.sp),
            child: TextButton(
              onPressed: () => print('object'),
              child: Text(
                'view all'.capitalize!,
                style: TextStyle(
                  fontSize: 3.6.sp,
                  color: Get.theme.colorScheme.onBackground,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
