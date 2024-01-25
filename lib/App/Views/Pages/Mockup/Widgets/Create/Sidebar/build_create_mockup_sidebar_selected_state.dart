import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/build_create_mockup_sidebar_selected_state_controller.dart';
import 'package:flutterpp/App/Enums/padding_destination_enum.dart';
import 'package:flutterpp/App/Models/gradient_model.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Steps/build_background_step.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Steps/build_device_step.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Steps/build_icon_step.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Steps/build_layout_step.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Steps/build_title_step.dart';
import 'package:get/get.dart';

class BuildCreateMockupSidebarSelectedState
    extends GetView<BuildCreateMockupSidebarSelectedStateController> {
  const BuildCreateMockupSidebarSelectedState({
    super.key,
    this.mockupId,
    this.initialColor,
    this.onImageUpload,
    this.onDeviceImageUpload,
    this.onSecondDeviceImageUpload,
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
    this.subtitleText,
    this.subtitleFontFamily,
    this.showSubtitle,
    this.subtitleAlignment,
    this.subtitleFontSize,
    this.subtitleLineHeight,
    this.subtitleColor,
    this.subtitleStrokeColor,
    this.subtitlePaddingTop,
    this.subtitlePaddingBottom,
    this.subtitlePaddingLeft,
    this.subtitlePaddingRight,
    this.onShowSubtitleChanged,
    this.onSubtitleAlignmentChanged,
    this.onSubtitleFontSizeChanged,
    this.onSubtitleLineHeightChanged,
    this.onSubtitleColorChanged,
    this.onSubtitlePaddingChanged,
    this.onSubtitleChanged,
    this.onTitleFontFamilyChanged,
    this.onSubtitleFontFamilyChanged,
    this.onUpdateDevicePossition,
    this.onUpdateFirstDeviceRotate,
    this.onUpdateFirstDeviceFullSize,
    this.updateFirstStrokeColor,
    this.updateFirstStrokeWidth,
    this.updateFirstDeviceFrame,
    this.updateFirstShadowColor,
    this.updateFirstDeviceShadowBlur,
    this.updateFirstDeviceShadowXOffset,
    this.updateFirstDeviceShadowYOffset,
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

  final String? titleText, subtitleText;
  final String? titleFontFamily, subtitleFontFamily;
  final bool? showTitle, showSubtitle;
  final MainAxisAlignment? titleAlignment, subtitleAlignment;
  final double? titleFontSize, subtitleFontSize;
  final double? titleLineHeight, subtitleLineHeight;
  final Color? titleColor, subtitleColor;
  final Color? titleStrokeColor, subtitleStrokeColor;
  final double? titlePaddingTop, subtitlePaddingTop;
  final double? titlePaddingBottom, subtitlePaddingBottom;
  final double? titlePaddingLeft, subtitlePaddingLeft;
  final double? titlePaddingRight, subtitlePaddingRight;

  final void Function(bool)? onShowTitleChanged,
      onShowSubtitleChanged,
      onIconToggle;
  final void Function(String)? onTitleChanged,
      onSubtitleChanged,
      onIconUpload,
      onImageUpload,
      onDeviceImageUpload,
      onSecondDeviceImageUpload;
  final void Function(String)? onSubtitleFontFamilyChanged,
      onTitleFontFamilyChanged;

  final void Function(MainAxisAlignment)? onTitleAlignmentChanged,
      onSubtitleAlignmentChanged,
      onIconAlignmentChanged;
  final void Function(double)? onTitleFontSizeChanged,
      onSubtitleFontSizeChanged,
      onTitleLineHeightChanged,
      onSubtitleLineHeightChanged;
  final void Function(Color)? onTitleColorChanged,
      onSubtitleColorChanged,
      onColorChangedCallback;
  final void Function(double, PaddingDestination)? onTitlePaddingChanged,
      onSubtitlePaddingChanged;

  final void Function(GradientModel)? onGradiantChangedCallback;
  final void Function(double padding, PaddingDestination destination)?
      onIconPaddingChanged;

  final void Function({
    double? firstDevicePositionTopBottom,
    double? firstDevicePositionRightLeft,
    double? secondDevicePositionTopBottom,
    double? secondDevicePositionRightLeft,
  })? onUpdateDevicePossition;
  final void Function(double rotate)? onUpdateFirstDeviceRotate;
  final void Function(bool value)? onUpdateFirstDeviceFullSize;
  final void Function(Color color)? updateFirstStrokeColor;
  final void Function(double width)? updateFirstStrokeWidth;
  final void Function(String frame)? updateFirstDeviceFrame;
  final void Function(Color color)? updateFirstShadowColor;
  final void Function(double blur)? updateFirstDeviceShadowBlur;
  final void Function(double offset)? updateFirstDeviceShadowXOffset;
  final void Function(double offset)? updateFirstDeviceShadowYOffset;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuildCreateMockupSidebarSelectedStateController>(
      init: BuildCreateMockupSidebarSelectedStateController(),
      initState: (_) {},
      builder: (_) {
        return ExpansionTileGroup(
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
              onTitleFontFamilyChanged: onTitleFontFamilyChanged,
            ),
            buildTitleStep(
              widgetTitle: 'Subtitle',
              titleSheetContext: context,
              titleText: subtitleText,
              titleFontFamily: subtitleFontFamily,
              showTitle: showSubtitle,
              titleAlignment: subtitleAlignment,
              titleFontSize: subtitleFontSize,
              titleLineHeight: subtitleLineHeight,
              titleColor: subtitleColor,
              titlePaddingTop: subtitlePaddingTop,
              titlePaddingBottom: subtitlePaddingBottom,
              titlePaddingLeft: subtitlePaddingLeft,
              titlePaddingRight: subtitlePaddingRight,
              onTitleChanged: onSubtitleChanged,
              onShowTitleChanged: onShowSubtitleChanged,
              onTitleAlignmentChanged: onSubtitleAlignmentChanged,
              onTitleFontSizeChanged: onSubtitleFontSizeChanged,
              onTitleLineHeightChanged: onSubtitleLineHeightChanged,
              onTitleColorChanged: onSubtitleColorChanged,
              onTitlePaddingChanged: onSubtitlePaddingChanged,
              onTitleFontFamilyChanged: onSubtitleFontFamilyChanged,
            ),
            buildDeviceStep(
              mockupId: mockupId,
              onDeviceImageUpload: onDeviceImageUpload,
              onSecondDeviceImageUpload: onSecondDeviceImageUpload,
              onUpdateDevicePossition: onUpdateDevicePossition,
              onUpdateFirstDeviceRotate: onUpdateFirstDeviceRotate,
              onUpdateFirstDeviceFullSize: onUpdateFirstDeviceFullSize,
              updateFirstStrokeColor: updateFirstStrokeColor,
              updateFirstStrokeWidth: updateFirstStrokeWidth,
              updateFirstDeviceFrame: updateFirstDeviceFrame,
              updateFirstShadowColor: updateFirstShadowColor,
              updateFirstDeviceShadowBlur: updateFirstDeviceShadowBlur,
              updateFirstDeviceShadowXOffset: updateFirstDeviceShadowXOffset,
              updateFirstDeviceShadowYOffset: updateFirstDeviceShadowYOffset,
            ),
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
        );
      },
    );
  }
}
