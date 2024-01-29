import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildDashboardNumbersItem extends StatelessWidget {
  const BuildDashboardNumbersItem({
    super.key,
    this.numbers,
    this.title,
    this.onTap,
    this.icon,
  });

  final int? numbers;
  final String? title;
  final VoidCallback? onTap;
  final IconData? icon;

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
                        title?.capitalize ?? 'Title',
                        style: TextStyle(
                          fontSize: 4.sp,
                          fontWeight: FontWeight.w400,
                          color: Get.theme.colorScheme.onBackground.withOpacity(
                            0.3,
                          ),
                        ),
                      ),
                      Text(
                        numbers?.toString() ?? '0',
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
                      icon ?? Icons.supervised_user_circle_rounded,
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
              onPressed: onTap,
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
