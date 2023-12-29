import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_create_mockup_sidebar_empty.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_create_mockup_sidebar_selected_state.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildCreateMockupSidebar extends StatelessWidget {
  final bool? isScreenshotSelected;

  const BuildCreateMockupSidebar({
    super.key,
    this.isScreenshotSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 100.h,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        border: Border(
          left: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 0.5,
          ),
        ),
      ),
      child: !isScreenshotSelected!
          ? const BuildCreateMockupSidebarEmpty()
          : const BuildCreateMockupSidebarSelectedState(),
    );
  }
}
