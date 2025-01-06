import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Enums/padding_destination_enum.dart';
import 'package:flutterpp/App/Views/Global/build_slider.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Widgets/build_select_image_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_alignment_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_slider_enable_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_sidebar_option.dart';

ExpansionTileItem buildingIconStep({
  bool? isIconToggled,
  String? mockupId,
  void Function(bool)? onIconToggle,
  void Function(String)? onIconUpload,
  void Function(MainAxisAlignment alignment)? onIconAlignmentChanged,
  MainAxisAlignment? initialAlignment,
  void Function(double padding, PaddingDestination destination)?
      onIconPaddingChanged,
  double? initialIconRightPadding,
  double? initialIconLeftPadding,
  double? initialIconBottomPadding,
  double? initialIconTopPadding,
}) {
  return ExpansionTileItem(
    title: const Text('Icon'),
    leading: const Icon(Icons.invert_colors_on_sharp),
    collapsedBorderColor: Colors.transparent,
    collapsedTextColor: Colors.grey.withValues(alpha: 0.8),
    collapsedIconColor: Colors.grey.withValues(alpha: 0.8),
    expendedBorderColor: Colors.grey.withValues(alpha: 0.2),
    textColor: Colors.white,
    iconColor: Colors.white,
    children: [
      BuildSliderEnableOption(
        controllerTag: 'iconEnable',
        initialValue: isIconToggled,
        onToggle: onIconToggle,
      ),
      const Divider(height: 30),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'logo',
        rightWidget: BuildSelectImageOption(
          title: 'add logo',
          controllerTag: 'logoImageUpload',
          mockupId: mockupId,
          callback: (val) => onIconUpload?.call(val),
        ),
      ),
      const SizedBox(height: 20),
      BuildAlignmentOption(
        controllerTag: 'iconAlignmentHorizontal',
        initialAlignment: initialAlignment,
        onToggle: onIconAlignmentChanged,
      ),
      const Divider(height: 40),
      const Text('Padding', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 20),
      Column(
        children: [
          BuildSidebarOption(
            title: 'Top',
            flexLeft: 1,
            flexRight: 3,
            rightWidget: BuildSlider(
                controllerTag: 'logoPaddingTop',
                defaultValue: initialIconTopPadding,
                onChanged: (val) => onIconPaddingChanged?.call(
                      val,
                      PaddingDestination.top,
                    )),
          ),
          const SizedBox(height: 10),
          BuildSidebarOption(
            title: 'Bottom',
            flexLeft: 1,
            flexRight: 3,
            rightWidget: BuildSlider(
              controllerTag: 'logoPaddingBottom',
              defaultValue: initialIconBottomPadding,
              onChanged: (val) => onIconPaddingChanged?.call(
                val,
                PaddingDestination.bottom,
              ),
            ),
          ),
          const SizedBox(height: 10),
          BuildSidebarOption(
            title: 'Left',
            flexLeft: 1,
            flexRight: 3,
            rightWidget: BuildSlider(
              controllerTag: 'logoPaddingLeft',
              defaultValue: initialIconLeftPadding,
              onChanged: (val) => onIconPaddingChanged?.call(
                val,
                PaddingDestination.left,
              ),
            ),
          ),
          const SizedBox(height: 10),
          BuildSidebarOption(
            title: 'Right',
            flexLeft: 1,
            flexRight: 3,
            rightWidget: BuildSlider(
              controllerTag: 'logoPaddingRight',
              defaultValue: initialIconRightPadding,
              onChanged: (val) => onIconPaddingChanged?.call(
                val,
                PaddingDestination.right,
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
    ],
  );
}
