import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_create_mockup_sidebar_empty.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_create_mockup_sidebar_selected_state.dart';
import 'package:get/get.dart';

class BuildCreateMockupSidebar extends StatelessWidget {
  final bool? isScreenshotSelected;

  const BuildCreateMockupSidebar({
    super.key,
    this.isScreenshotSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          border: Border(
            left: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width: 0.5,
            ),
          ),
        ),
        width: Get.width * 0.25,
        child: !isScreenshotSelected!
            ? const BuildCreateMockupSidebarEmpty()
            : const BuildCreateMockupSidebarSelectedState(),
      ),
    );
  }
}
