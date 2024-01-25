import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_alignment_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_pick_color.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_slider_enable_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_slider_with_value_box.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_sidebar_option.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

ExpansionTileBorderItem buildDeviceStep({
  String? title,
  Widget? leading,
  bool? hasVisabeltyOption = false,
  double? firstDeviceRotateInitialValue,
  void Function({
    double? devicePositionBottom,
    double? devicePositionLeft,
    double? devicePositionRight,
    double? devicePositionTop,
  })? onUpdateFirstDevicePosition,
  void Function(double rotate)? onUpdateFirstDeviceRotate,
  void Function(bool value)? onUpdateFirstDeviceFullSize,
  void Function(Color color)? updateFirstStrokeColor,
  void Function(double width)? updateFirstStrokeWidth,
  void Function(String frame)? updateFirstDeviceFrame,
  void Function(Color color)? updateFirstShadowColor,
  void Function(double blur)? updateFirstDeviceShadowBlur,
  void Function(double offset)? updateFirstDeviceShadowXOffset,
  void Function(double offset)? updateFirstDeviceShadowYOffset,
}) {
  String uuid = const Uuid().v4();
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
      if (hasVisabeltyOption!)
        BuildSliderEnableOption(
          controllerTag: 'deviceEnable-$uuid',
        ),
      const Divider(height: 30),
      const Text('Alignment'),
      const SizedBox(height: 10),
      BuildAlignmentOption(
        title: '',
        controllerTag: 'deviceAlignmentHorizontal-$uuid',
      ),
      BuildAlignmentOption(
        title: '',
        controllerTag: 'deviceAlignmentVertical-$uuid',
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
          controllerTag: 'deviceSize-$uuid',
          onChanged: (val) => print('❌ - $val'),
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'Rotate',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: 'deviceRotate-$uuid',
          min: -180,
          max: 180,
          divisions: 360,
          defaultValue: firstDeviceRotateInitialValue ?? 0,
          onChanged: (val) => onUpdateFirstDeviceRotate?.call(
            val / 180,
          ),
        ),
      ),
      const SizedBox(height: 20),
      BuildSidebarOption(
        title: 'Stroke',
        rightWidget: BuildPickColor(
          controllerTag: 'deviceStrokeColor-$uuid',
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'Shadow',
        rightWidget: BuildPickColor(
          controllerTag: 'deviceShadowColor-$uuid',
        ),
      ),
      const SizedBox(height: 30),
      const Text('Position'),
      const SizedBox(height: 30),
      BuildSidebarOption(
        title: 'Top',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: 'devicePositionTop-$uuid',
          min: 0,
          max: Get.height,
          divisions: Get.height.toInt(),
          onChanged: (val) => onUpdateFirstDevicePosition?.call(
            devicePositionTop: val,
          ),
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'Bottom',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: 'devicePositionBottom-$uuid',
          min: 0,
          max: Get.height,
          divisions: Get.height.toInt(),
          onChanged: (val) => onUpdateFirstDevicePosition?.call(
            devicePositionBottom: val,
          ),
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'Left',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: 'devicePositionLeft-$uuid',
          min: 0,
          max: Get.width,
          divisions: Get.width.toInt(),
          onChanged: (val) => onUpdateFirstDevicePosition?.call(
            devicePositionLeft: val,
          ),
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'Right',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: 'devicePositionRight-$uuid',
          min: 0,
          max: Get.width,
          divisions: Get.width.toInt(),
          onChanged: (val) => onUpdateFirstDevicePosition?.call(
            devicePositionRight: val,
          ),
        ),
      ),
    ],
  );
}
