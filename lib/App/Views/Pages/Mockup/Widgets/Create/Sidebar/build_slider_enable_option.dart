import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/Micro/bool_toggle_controller.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_sidebar_option.dart';
import 'package:get/get.dart';

class BuildSliderEnableOption extends GetView<BoolToggleController> {
  final void Function(bool)? onToggle;
  final String? controllerTag;

  const BuildSliderEnableOption({
    super.key,
    this.onToggle,
    this.controllerTag,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoolToggleController>(
      init: BoolToggleController(),
      tag: controllerTag,
      builder: (_) {
        return BuildSidebarOption(
          title: 'Enable',
          rightWidget: Obx(
            () => Switch(
              value: _.isOn,
              onChanged: (bool value) {
                _.toggle();
                onToggle?.call(value);
              },
              activeColor: Get.theme.primaryColor,
            ),
          ),
        );
      },
    );
  }
}
