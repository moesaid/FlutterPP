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
  final void Function(String)? onImageUpload;
  final void Function(Color)? onColorChangedCallback;
  final void Function(GradientModel)? onGradiantChangedCallback;
  final void Function(bool)? onIconToggle;
  final void Function(String)? onIconUpload;
  final void Function(MainAxisAlignment alignment)? onIconAlignmentChanged;
  final void Function(double padding, PaddingDestination destination)?
      onIconPaddingChanged;

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
          : BuildCreateMockupSidebarSelectedState(
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
            ),
    );
  }
}
