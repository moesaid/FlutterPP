import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Enums/padding_destination_enum.dart';
import 'package:flutterpp/App/Models/gradient_model.dart';
import 'package:flutterpp/App/Models/template_config_model.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_create_mockup_sidebar_empty.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_create_mockup_sidebar_selected_state.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildCreateMockupSidebar extends StatelessWidget {
  final bool? isScreenshotSelected;
  final String? mockupId, firstInitalDeviceFrame, secondInitalDeviceFrame;
  final Color? initialColor;
  final GradientModel? activeGradient;
  final bool? isIconToggled;
  final MainAxisAlignment? initialAlignment;
  final double? initialIconRightPadding;
  final double? initialIconLeftPadding;
  final double? initialIconBottomPadding;
  final double? initialIconTopPadding;

  final String? titleText, subtitleText, layoutName;
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

  final void Function(bool)? onShowTitleChanged, onShowSubtitleChanged;
  final void Function(String)? onTitleChanged, onSubtitleChanged;
  final void Function(String)? onTitleFontFamilyChanged,
      onSubtitleFontFamilyChanged;
  final void Function(MainAxisAlignment)? onTitleAlignmentChanged,
      onSubtitleAlignmentChanged;
  final void Function(double)? onTitleFontSizeChanged,
      onSubtitleFontSizeChanged;
  final void Function(double)? onTitleLineHeightChanged,
      onSubtitleLineHeightChanged;
  final void Function(Color)? onTitleColorChanged, onSubtitleColorChanged;

  final void Function(double, PaddingDestination)? onTitlePaddingChanged,
      onSubtitlePaddingChanged;
  final void Function(String, {bool? repeatForAll})? onImageUpload;
  final void Function(Color, {bool? repeatForAll})? onColorChangedCallback;
  final void Function(GradientModel, {bool? repeatForAll})?
      onGradiantChangedCallback;
  final void Function(bool)? onIconToggle;
  final void Function(String)? onIconUpload;
  final void Function(MainAxisAlignment alignment)? onIconAlignmentChanged;
  final void Function(double padding, PaddingDestination destination)?
      onIconPaddingChanged;

  // Device
  final bool? showDevice;
  final bool? showSecondDevice;
  final bool? showFrame;
  final bool? showSecondFrame;
  final bool? showStroke;
  final bool? showSecondStroke;
  final Color? strokeColor;
  final Color? secondStrokeColor;
  final double? strokeWidth;
  final double? secondStrokeWidth;
  final Color? shadowColor;
  final Color? secondShadowColor;
  final double? shadowBlur;
  final double? secondShadowBlur;
  final double? shadowOffsetX;
  final double? secondShadowOffsetX;
  final double? shadowOffsetY;
  final double? secondShadowOffsetY;
  final double? secondRotate;
  final double? rotate;
  final double? firstDeviceVerticalPosition;
  final double? firstDeviceHorizontalPosition;
  final double? secondDeviceVerticalPosition;
  final double? secondDeviceHorizontalPosition;

  final void Function(double scale, {bool? isSecondDevice})? updateDeviceScale;
  final double? secondScale;
  final double? scale;

  final void Function(bool value, {bool? isSecondDevice})?
      updateDeviceStrokeVisibility;
  final void Function({
    double? horizontalPosition,
    double? verticalPosition,
    double? secondHorizontalPosition,
    double? secondVerticalPosition,
  })? onUpdateDevicePossition;
  final void Function(double rotate, {bool? isSecondDevice})?
      updateDeviceRotate;
  final void Function(bool value, {bool? isSecondDevice})? updateDeviceFullSize;
  final void Function(Color color, {bool? isSecondDevice})? updateStrokeColor;
  final void Function(double width, {bool? isSecondDevice})? updateStrokeWidth;
  final void Function(Color color, {bool? isSecondDevice})? updateShadowColor;
  final void Function(double blur, {bool? isSecondDevice})?
      updateDeviceShadowBlur;
  final void Function(double offset, {bool? isSecondDevice})?
      updateDeviceShadowXOffset;
  final void Function(double offset, {bool? isSecondDevice})?
      updateDeviceShadowYOffset;
  final void Function(String frame, {bool? isSecondDevice})?
      onDeviceImageUpload;
  final void Function(DeviceInfo device, {bool? isSecondDevice})?
      updateDeviceFrame;

  final void Function(bool value, {bool? isSecondDevice})? updateShowDevice;
  final void Function(bool value, {bool? isSecondDevice})?
      updateShowDeviceFrame;
  final void Function(TemplateConfigModel layout)? updateLayout;
  final void Function(bool value, {bool? isSecondDevice})?
      updateDeviceShadowVisibility;

  const BuildCreateMockupSidebar({
    super.key,
    this.isScreenshotSelected = false,
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
    this.updateDeviceRotate,
    this.updateDeviceFullSize,
    this.updateStrokeColor,
    this.updateStrokeWidth,
    this.updateDeviceFrame,
    this.updateShadowColor,
    this.updateDeviceShadowBlur,
    this.updateDeviceShadowXOffset,
    this.updateDeviceShadowYOffset,
    this.onDeviceImageUpload,
    this.firstInitalDeviceFrame,
    this.secondInitalDeviceFrame,
    this.showDevice,
    this.showSecondDevice,
    this.showFrame,
    this.showSecondFrame,
    this.updateShowDevice,
    this.updateShowDeviceFrame,
    this.showStroke,
    this.showSecondStroke,
    this.strokeColor,
    this.secondStrokeColor,
    this.strokeWidth,
    this.secondStrokeWidth,
    this.shadowColor,
    this.secondShadowColor,
    this.shadowBlur,
    this.secondShadowBlur,
    this.shadowOffsetX,
    this.secondShadowOffsetX,
    this.shadowOffsetY,
    this.secondShadowOffsetY,
    this.updateDeviceStrokeVisibility,
    this.firstDeviceVerticalPosition,
    this.firstDeviceHorizontalPosition,
    this.secondDeviceVerticalPosition,
    this.secondDeviceHorizontalPosition,
    this.secondRotate,
    this.rotate,
    this.updateDeviceScale,
    this.secondScale,
    this.scale,
    this.updateLayout,
    this.layoutName,
    this.updateDeviceShadowVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: context.height,
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        border: Border(
          left: BorderSide(
            color: Colors.grey.withValues(alpha: 0.2),
            width: 0.5,
          ),
        ),
      ),
      child: Container(
        width: 300,
        height: 600,
        padding: EdgeInsets.only(
          top: 15,
          bottom: 40.spa,
          left: 15,
          right: 15,
        ),
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          border: Border(
            left: BorderSide(
              color: Colors.grey.withValues(alpha: 0.2),
              width: 0.5,
            ),
          ),
        ),
        child: !isScreenshotSelected!
            ? const BuildCreateMockupSidebarEmpty()
            : SingleChildScrollView(
                child: BuildCreateMockupSidebarSelectedState(
                  initialColor: initialColor,
                  activeGradient: activeGradient,
                  mockupId: mockupId,
                  onImageUpload: onImageUpload,
                  onColorChangedCallback: onColorChangedCallback,
                  onGradiantChangedCallback: onGradiantChangedCallback,
                  onIconToggle: onIconToggle,
                  isIconToggled: isIconToggled,
                  onIconUpload: onIconUpload,
                  onIconAlignmentChanged: onIconAlignmentChanged,
                  initialAlignment: initialAlignment,
                  onIconPaddingChanged: onIconPaddingChanged,
                  initialIconTopPadding: initialIconTopPadding,
                  initialIconBottomPadding: initialIconBottomPadding,
                  initialIconLeftPadding: initialIconLeftPadding,
                  initialIconRightPadding: initialIconRightPadding,
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
                  onShowTitleChanged: onShowTitleChanged,
                  onTitleAlignmentChanged: onTitleAlignmentChanged,
                  onTitleFontSizeChanged: onTitleFontSizeChanged,
                  onTitleLineHeightChanged: onTitleLineHeightChanged,
                  onTitleColorChanged: onTitleColorChanged,
                  onTitlePaddingChanged: onTitlePaddingChanged,
                  onTitleChanged: onTitleChanged,
                  subtitleText: subtitleText,
                  subtitleFontFamily: subtitleFontFamily,
                  showSubtitle: showSubtitle,
                  subtitleAlignment: subtitleAlignment,
                  subtitleFontSize: subtitleFontSize,
                  subtitleLineHeight: subtitleLineHeight,
                  subtitleColor: subtitleColor,
                  subtitleStrokeColor: subtitleStrokeColor,
                  subtitlePaddingTop: subtitlePaddingTop,
                  subtitlePaddingBottom: subtitlePaddingBottom,
                  subtitlePaddingLeft: subtitlePaddingLeft,
                  subtitlePaddingRight: subtitlePaddingRight,
                  onShowSubtitleChanged: onShowSubtitleChanged,
                  onSubtitleAlignmentChanged: onSubtitleAlignmentChanged,
                  onSubtitleFontSizeChanged: onSubtitleFontSizeChanged,
                  onSubtitleLineHeightChanged: onSubtitleLineHeightChanged,
                  onSubtitleColorChanged: onSubtitleColorChanged,
                  onSubtitlePaddingChanged: onSubtitlePaddingChanged,
                  onSubtitleChanged: onSubtitleChanged,
                  onTitleFontFamilyChanged: onTitleFontFamilyChanged,
                  onSubtitleFontFamilyChanged: onSubtitleFontFamilyChanged,
                  onUpdateDevicePossition: onUpdateDevicePossition,
                  updateDeviceRotate: updateDeviceRotate,
                  updateDeviceFullSize: updateDeviceFullSize,
                  updateDeviceFrame: updateDeviceFrame,
                  onDeviceImageUpload: onDeviceImageUpload,
                  firstInitalDeviceFrame: firstInitalDeviceFrame,
                  secondInitalDeviceFrame: secondInitalDeviceFrame,
                  showDevice: showDevice,
                  showSecondDevice: showSecondDevice,
                  showFrame: showFrame,
                  showSecondFrame: showSecondFrame,
                  updateShowDevice: updateShowDevice,
                  updateShowDeviceFrame: updateShowDeviceFrame,
                  showStroke: showStroke,
                  showSecondStroke: showSecondStroke,
                  strokeColor: strokeColor,
                  secondStrokeColor: secondStrokeColor,
                  strokeWidth: strokeWidth,
                  secondStrokeWidth: secondStrokeWidth,
                  shadowColor: shadowColor,
                  secondShadowColor: secondShadowColor,
                  shadowBlur: shadowBlur,
                  secondShadowBlur: secondShadowBlur,
                  shadowOffsetX: shadowOffsetX,
                  secondShadowOffsetX: secondShadowOffsetX,
                  shadowOffsetY: shadowOffsetY,
                  secondShadowOffsetY: secondShadowOffsetY,
                  updateDeviceStrokeVisibility: updateDeviceStrokeVisibility,
                  updateStrokeWidth: updateStrokeWidth,
                  updateStrokeColor: updateStrokeColor,
                  updateShadowColor: updateShadowColor,
                  updateDeviceShadowBlur: updateDeviceShadowBlur,
                  updateDeviceShadowXOffset: updateDeviceShadowXOffset,
                  updateDeviceShadowYOffset: updateDeviceShadowYOffset,
                  firstDeviceVerticalPosition: firstDeviceVerticalPosition,
                  firstDeviceHorizontalPosition: firstDeviceHorizontalPosition,
                  secondDeviceVerticalPosition: secondDeviceVerticalPosition,
                  secondDeviceHorizontalPosition:
                      secondDeviceHorizontalPosition,
                  secondRotate: secondRotate,
                  rotate: rotate,
                  updateDeviceScale: updateDeviceScale,
                  secondScale: secondScale,
                  scale: scale,
                  updateLayout: updateLayout,
                  layoutName: layoutName,
                  updateDeviceShadowVisibility: updateDeviceShadowVisibility,
                ),
              ),
      ),
    );
  }
}
