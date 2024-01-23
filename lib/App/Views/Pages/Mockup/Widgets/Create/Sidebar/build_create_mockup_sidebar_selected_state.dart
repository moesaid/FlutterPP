import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/build_create_mockup_sidebar_selected_state_controller.dart';
import 'package:flutterpp/App/Enums/padding_destination_enum.dart';
import 'package:flutterpp/App/Models/gradient_model.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Steps/build_background_step.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Steps/build_device_step.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Steps/build_icon_step.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Steps/build_layout_step.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Steps/build_subtitle_step.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Steps/build_title_step.dart';
import 'package:get/get.dart';

class BuildCreateMockupSidebarSelectedState
    extends GetView<BuildCreateMockupSidebarSelectedStateController> {
  const BuildCreateMockupSidebarSelectedState({
    super.key,
    this.mockupId,
    this.initialColor,
    this.onImageUpload,
    this.onColorChangedCallback,
    this.onGradiantChangedCallback,
    this.activeGradient,
    this.onIconToggle,
    this.isIconToggled,
    this.onIconUpload,
    this.onIconAlignmentChanged,
    this.initialAlignment,
    this.onIconPaddingChanged,
    this.initialIconTopPadding,
    this.initialIconBottomPadding,
    this.initialIconLeftPadding,
    this.initialIconRightPadding,
  });

  final String? mockupId;
  final Color? initialColor;
  final GradientModel? activeGradient;
  final bool? isIconToggled;
  final MainAxisAlignment? initialAlignment;
  final double? initialIconRightPadding;
  final double? initialIconLeftPadding;
  final double? initialIconBottomPadding;
  final double? initialIconTopPadding;
  final void Function(bool)? onIconToggle;
  final void Function(String)? onIconUpload;
  final void Function(String)? onImageUpload;
  final void Function(Color)? onColorChangedCallback;
  final void Function(GradientModel)? onGradiantChangedCallback;
  final void Function(MainAxisAlignment alignment)? onIconAlignmentChanged;
  final void Function(double padding, PaddingDestination destination)?
      onIconPaddingChanged;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuildCreateMockupSidebarSelectedStateController>(
      init: BuildCreateMockupSidebarSelectedStateController(),
      initState: (_) {},
      builder: (_) {
        return SingleChildScrollView(
          child: ExpansionTileGroup(
            toggleType: ToggleType.expandOnlyCurrent,
            children: [
              buildLayoutStep(),
              buildBackgroundStep(
                mockupId: mockupId,
                controller: controller,
                initialColor: initialColor,
                onImageUpload: onImageUpload,
                activeGradient: activeGradient,
                onColorChangedCallback: onColorChangedCallback,
                onGradiantChangedCallback: onGradiantChangedCallback,
              ),
              buildingIconStep(
                mockupId: mockupId,
                isIconToggled: isIconToggled,
                onIconToggle: onIconToggle,
                onIconUpload: onIconUpload,
                initialAlignment: initialAlignment,
                initialIconTopPadding: initialIconTopPadding,
                initialIconBottomPadding: initialIconBottomPadding,
                initialIconLeftPadding: initialIconLeftPadding,
                initialIconRightPadding: initialIconRightPadding,
                onIconAlignmentChanged: onIconAlignmentChanged,
                onIconPaddingChanged: onIconPaddingChanged,
              ),
              buildTitleStep(),
              buildSubtitleStep(),
              buildDeviceStep(),
              buildDeviceStep(
                title: 'Device Two',
                leading: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.devices),
                    Icon(Icons.looks_two_outlined),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
