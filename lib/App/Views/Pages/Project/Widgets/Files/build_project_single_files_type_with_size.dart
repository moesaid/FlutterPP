import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildProjectSingleFilesTypeWithSize extends StatelessWidget {
  final Color? color;
  final IconData? icon;
  final String? title, size;
  const BuildProjectSingleFilesTypeWithSize({
    super.key,
    this.color,
    this.icon,
    this.title,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 2.sp,
        horizontal: 4.sp,
      ),
      decoration: BoxDecoration(
        color:
            color?.withOpacity(0.07) ?? Get.theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon ?? Icons.folder,
            size: 5.sp,
            color: color,
          ),
          SizedBox(width: 2.sp),
          Text(
            title?.capitalize ?? 'Files',
            style: TextStyle(color: color),
          ),
          const Spacer(),
          Text(
            size ?? '',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
