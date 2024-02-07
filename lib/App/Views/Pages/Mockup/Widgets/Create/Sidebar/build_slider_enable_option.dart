import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/Micro/bool_toggle_controller.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_sidebar_option.dart';
import 'package:get/get.dart';

class BuildSliderEnableOption extends GetView<BoolToggleController> {
  final void Function(bool)? onToggle;
  final String? controllerTag, title;
  final bool? initialValue;
  final int? flexLeft, flexRight;
  final FontWeight? fontWeight;

  const BuildSliderEnableOption({
    super.key,
    this.title,
    this.onToggle,
    this.controllerTag,
    this.initialValue,
    this.flexLeft,
    this.flexRight,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BoolToggleController>(
      init: BoolToggleController(),
      tag: controllerTag,
      didChangeDependencies: (state) {
        state.controller?.setInitialValue(initialValue ?? false);
      },
      builder: (_) {
        return BuildSidebarOption(
          title: title ?? 'Enable',
          flexLeft: flexLeft,
          flexRight: flexRight,
          fontWeight: fontWeight,
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
