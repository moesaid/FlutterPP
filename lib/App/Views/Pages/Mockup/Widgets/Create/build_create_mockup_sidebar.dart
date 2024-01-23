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
            ),
    );
  }
}
