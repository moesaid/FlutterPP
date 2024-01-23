import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Global/build_slider.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Widgets/build_select_image_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_alignment_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_slider_enable_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_sidebar_option.dart';

ExpansionTileBorderItem buildingIconStep({
  bool? isIconToggled,
  String? mockupId,
  void Function(bool)? onIconToggle,
  void Function(String)? onIconUpload,
  void Function(MainAxisAlignment alignment)? onIconAlignmentChanged,
  MainAxisAlignment? initialAlignment,
}) {
  return ExpansionTileBorderItem(
    title: const Text('Icon'),
    leading: const Icon(Icons.invert_colors_on_sharp),
    collapsedBorderColor: Colors.transparent,
    collapsedTextColor: Colors.grey.withOpacity(0.8),
    collapsedIconColor: Colors.grey.withOpacity(0.8),
    expendedBorderColor: Colors.grey.withOpacity(0.2),
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
      const SizedBox(height: 20),
      BuildSidebarOption(
        title: 'Margin',
        rightWidget: BuildSlider(
          controllerTag: 'iconMargin',
          onChanged: (val) => print('❌ - $val'),
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}
