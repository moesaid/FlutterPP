import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/build_create_mockup_sidebar_selected_state_controller.dart';
import 'package:get/get.dart';

class BuildCreateMockupSidebarSelectedState
    extends GetView<BuildCreateMockupSidebarSelectedStateController> {
  const BuildCreateMockupSidebarSelectedState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuildCreateMockupSidebarSelectedStateController>(
      init: BuildCreateMockupSidebarSelectedStateController(),
      initState: (_) {},
      builder: (_) {
        return const Column(
          children: [
            Text(
              'Selected screenshot',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        );
      },
    );
  }
}
