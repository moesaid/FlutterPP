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
    this.titleText,
    this.titleFontFamily,
    this.showTitle,
    this.titleAlignment,
    this.titleFontSize,
    this.titleLineHeight,
    this.titleColor,
    this.titleStrokeColor,
    this.titlePaddingTop,
    this.titlePaddingBottom,
    this.titlePaddingLeft,
    this.titlePaddingRight,
    this.onShowTitleChanged,
    this.onTitleAlignmentChanged,
    this.onTitleFontSizeChanged,
    this.onTitleLineHeightChanged,
    this.onTitleColorChanged,
    this.onTitlePaddingChanged,
    this.onTitleChanged,
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
  final String? titleText;
  final String? titleFontFamily;
  final bool? showTitle;
  final MainAxisAlignment? titleAlignment;
  final double? titleFontSize;
  final double? titleLineHeight;
  final Color? titleColor;
  final Color? titleStrokeColor;
  final double? titlePaddingTop;
  final double? titlePaddingBottom;
  final double? titlePaddingLeft;
  final double? titlePaddingRight;

  final void Function(bool)? onShowTitleChanged;
  final void Function(String)? onTitleChanged;
  final void Function(MainAxisAlignment)? onTitleAlignmentChanged;
  final void Function(double)? onTitleFontSizeChanged;
  final void Function(double)? onTitleLineHeightChanged;
  final void Function(Color)? onTitleColorChanged;

  final void Function(double, PaddingDestination)? onTitlePaddingChanged;
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
              buildTitleStep(
                titleSheetContext: context,
                titleText: titleText,
                titleFontFamily: titleFontFamily,
                showTitle: showTitle,
                titleAlignment: titleAlignment,
                titleFontSize: titleFontSize,
                titleLineHeight: titleLineHeight,
                titleColor: titleColor,
                titleStrokeColor: titleStrokeColor,
                titlePaddingTop: titlePaddingTop,
                titlePaddingBottom: titlePaddingBottom,
                titlePaddingLeft: titlePaddingLeft,
                titlePaddingRight: titlePaddingRight,
                onTitleChanged: onTitleChanged,
                onShowTitleChanged: onShowTitleChanged,
                onTitleAlignmentChanged: onTitleAlignmentChanged,
                onTitleFontSizeChanged: onTitleFontSizeChanged,
                onTitleLineHeightChanged: onTitleLineHeightChanged,
                onTitleColorChanged: onTitleColorChanged,
                onTitlePaddingChanged: onTitlePaddingChanged,
              ),
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
