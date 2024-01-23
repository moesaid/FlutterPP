import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_alignment_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_pick_color.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_slider_enable_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_slider_with_value_box.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_sidebar_option.dart';
import 'package:get/get.dart';

ExpansionTileBorderItem buildDeviceStep({
  String? title,
  Widget? leading,
}) {
  return ExpansionTileBorderItem(
    title: Text(title ?? 'Device'),
    leading: leading ?? const Icon(Icons.devices),
    collapsedBorderColor: Colors.transparent,
    collapsedTextColor: Colors.grey.withOpacity(0.8),
    collapsedIconColor: Colors.grey.withOpacity(0.8),
    expendedBorderColor: Colors.grey.withOpacity(0.2),
    textColor: Colors.white,
    iconColor: Colors.white,
    children: [
      const BuildSliderEnableOption(
        controllerTag: 'deviceEnable',
      ),
      const Divider(height: 30),
      const SizedBox(height: 10),
      const BuildAlignmentOption(
        title: '',
        controllerTag: 'deviceAlignmentHorizontal',
      ),
      const BuildAlignmentOption(
        title: '',
        controllerTag: 'deviceAlignmentVertical',
        firtIcon: Icons.vertical_align_top_rounded,
        secondIcon: Icons.vertical_align_center_rounded,
        thirdIcon: Icons.vertical_align_bottom_rounded,
      ),
      const SizedBox(height: 20),
      BuildSidebarOption(
        title: 'Screen',
        rightWidget: ElevatedButton(
          onPressed: () {},
          child: Text('add Screen'.capitalize!),
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'Frame',
        rightWidget: ElevatedButton(
          onPressed: () {},
          child: Text('edit Frame'.capitalize!),
        ),
      ),
      const SizedBox(height: 20),
      BuildSidebarOption(
        title: 'Size',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: 'deviceSize',
          onChanged: (val) => print('❌ - $val'),
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'Rotate',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: 'deviceRotate',
          onChanged: (val) => print('❌ - $val'),
        ),
      ),
      const SizedBox(height: 20),
      const BuildSidebarOption(
        title: 'Stroke',
        rightWidget: BuildPickColor(
          controllerTag: 'deviceStrokeColor',
        ),
      ),
      const SizedBox(height: 10),
      const BuildSidebarOption(
        title: 'Shadow',
        rightWidget: BuildPickColor(
          controllerTag: 'deviceShadowColor',
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}
