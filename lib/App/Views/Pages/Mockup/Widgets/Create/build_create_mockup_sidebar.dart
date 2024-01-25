import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Enums/padding_destination_enum.dart';
import 'package:flutterpp/App/Models/gradient_model.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_create_mockup_sidebar_empty.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_create_mockup_sidebar_selected_state.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildCreateMockupSidebar extends StatelessWidget {
  final bool? isScreenshotSelected;
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
  final void Function(String)? onImageUpload;
  final void Function(Color)? onColorChangedCallback;
  final void Function(GradientModel)? onGradiantChangedCallback;
  final void Function(bool)? onIconToggle;
  final void Function(String)? onIconUpload;
  final void Function(MainAxisAlignment alignment)? onIconAlignmentChanged;
  final void Function(double padding, PaddingDestination destination)?
      onIconPaddingChanged;

  // Device
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
  final void Function(Color color)? updateFirstShadowColor;
  final void Function(double blur)? updateFirstDeviceShadowBlur;
  final void Function(double offset)? updateFirstDeviceShadowXOffset;
  final void Function(double offset)? updateFirstDeviceShadowYOffset;
  final void Function(String frame)? onDeviceImageUpload;
  final void Function(String frame)? onSecondDeviceImageUpload;
  final void Function(DeviceInfo)? updateFirstDeviceFrame,
      updateSecondDeviceFrame;

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
    this.onUpdateFirstDeviceRotate,
    this.onUpdateFirstDeviceFullSize,
    this.updateFirstStrokeColor,
    this.updateFirstStrokeWidth,
    this.updateFirstDeviceFrame,
    this.updateSecondDeviceFrame,
    this.updateFirstShadowColor,
    this.updateFirstDeviceShadowBlur,
    this.updateFirstDeviceShadowXOffset,
    this.updateFirstDeviceShadowYOffset,
    this.onDeviceImageUpload,
    this.onSecondDeviceImageUpload,
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
            color: Colors.grey.withOpacity(0.2),
            width: 0.5,
          ),
        ),
      ),
      child: Container(
        width: 300,
        height: 600,
        padding: EdgeInsets.only(
          top: 15,
          bottom: 20.sp,
          left: 15,
          right: 15,
        ),
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
                  onUpdateFirstDeviceRotate: onUpdateFirstDeviceRotate,
                  onUpdateFirstDeviceFullSize: onUpdateFirstDeviceFullSize,
                  onDeviceImageUpload: onDeviceImageUpload,
                  onSecondDeviceImageUpload: onSecondDeviceImageUpload,
                  updateFirstDeviceFrame: updateFirstDeviceFrame,
                  updateSecondDeviceFrame: updateSecondDeviceFrame,
                ),
              ),
      ),
    );
  }
}
