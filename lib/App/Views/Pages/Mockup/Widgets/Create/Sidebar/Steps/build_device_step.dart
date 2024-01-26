import 'package:device_frame/device_frame.dart';
import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Widgets/build_edit_frame_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Widgets/build_select_image_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_pick_color.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_slider_enable_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_slider_with_value_box.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_sidebar_option.dart';
import 'package:uuid/uuid.dart';

ExpansionTileBorderItem buildDeviceStep({
  String? title,
  String? mockupId,
  Widget? leading,
  String? initalFrame,
  bool? showFrame = true,
  bool? isSecondDevice = false,
  double? rotate,
  double? secondRotate,
  bool? showStroke,
  bool? showSecondStroke,
  Color? strokeColor,
  Color? secondStrokeColor,
  double? strokeWidth,
  double? secondStrokeWidth,
  Color? shadowColor,
  Color? secondShadowColor,
  double? shadowBlur,
  double? secondShadowBlur,
  double? shadowOffsetX,
  double? secondShadowOffsetX,
  double? shadowOffsetY,
  double? secondShadowOffsetY,
  double? firstDeviceVerticalPosition,
  double? firstDeviceHorizontalPosition,
  double? secondDeviceVerticalPosition,
  double? secondDeviceHorizontalPosition,
  void Function(bool value, {bool? isSecondDevice})?
      updateDeviceStrokeVisibility,
  void Function({
    double? horizontalPosition,
    double? verticalPosition,
    double? secondHorizontalPosition,
    double? secondVerticalPosition,
  })? updateDevicePossition,
  void Function(double rotate, {bool? isSecondDevice})? updateDeviceRotate,
  void Function(bool value, {bool? isSecondDevice})? updateDeviceFullSize,
  void Function(Color color, {bool? isSecondDevice})? updateStrokeColor,
  void Function(double width, {bool? isSecondDevice})? updateStrokeWidth,
  void Function(Color color, {bool? isSecondDevice})? updateShadowColor,
  void Function(double blur, {bool? isSecondDevice})? updateDeviceShadowBlur,
  void Function(double offset, {bool? isSecondDevice})?
      updateDeviceShadowXOffset,
  void Function(double offset, {bool? isSecondDevice})?
      updateDeviceShadowYOffset,
  void Function(String frame, {bool? isSecondDevice})? onDeviceImageUpload,
  void Function(DeviceInfo device, {bool? isSecondDevice})? updateDeviceFrame,
  void Function(bool value, {bool? isSecondDevice})? updateShowDevice,
  void Function(bool value, {bool? isSecondDevice})? updateShowDeviceFrame,
  bool? showDevice,
}) {
  String uuid = const Uuid().v4();
  print('😀 ${(rotate ?? 0 * 100 / 180)}');
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
      BuildSliderEnableOption(
        title: 'Enable',
        initialValue: showDevice,
        controllerTag: 'deviceEnable-bool-$uuid',
        onToggle: (val) => updateShowDevice?.call(val),
      ),
      BuildSliderEnableOption(
        title: 'Frame',
        initialValue: showFrame,
        controllerTag: 'deviceFrame-bool-$uuid',
        onToggle: (val) => updateShowDeviceFrame?.call(val),
      ),
      const SizedBox(height: 20),
      BuildSidebarOption(
        title: 'Screen',
        rightWidget: BuildSelectImageOption(
          mockupId: mockupId,
          controllerTag: 'devideImage-$uuid',
          callback: (val) {
            onDeviceImageUpload?.call(val);
          },
        ),
      ),
      const SizedBox(height: 10),

      BuildSidebarOption(
        title: 'Frame',
        rightWidget: BuildEditFrame(
          controllerTag: 'deviceFrame-$uuid',
          initialValue: initalFrame,
          callback: updateDeviceFrame,
        ),
      ),
      const SizedBox(height: 20),
      // BuildSidebarOption(
      //   title: 'Size',
      //   rightWidget: BuildSliderWithValueBox(
      //     controllerTag: 'deviceSize-$uuid',
      //     onChanged: (val) => print('❌ - $val'),
      //   ),
      // ),
      // const SizedBox(height: 10),

      const Divider(height: 50),
      const Text(
        'Stroke',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 20),
      BuildSliderEnableOption(
        title: 'Enable',
        initialValue: showStroke,
        controllerTag: 'deviceStrokeEnable-bool-$uuid',
        onToggle: (val) => updateDeviceStrokeVisibility?.call(val),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'Color',
        rightWidget: BuildPickColor(
          controllerTag: 'deviceStrokeColor-$uuid',
          initialColor: strokeColor,
          onColorChangedCallback: (val) => updateStrokeColor?.call(val),
        ),
      ),

      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'Width',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: 'deviceStrokeWidth-$uuid',
          min: 8,
          max: 20,
          divisions: 12,
          defaultValue: strokeWidth ?? 0,
          onChanged: (val) => updateStrokeWidth?.call(val),
        ),
      ),

      const Divider(height: 50),
      BuildSidebarOption(
        title: 'Shadow',
        rightWidget: BuildPickColor(
          controllerTag: 'deviceShadowColor-$uuid',
        ),
      ),
      const Divider(height: 50),
      const Text(
        'Position',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 20),
      BuildSidebarOption(
        title: 'Rotate',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: 'deviceRotate-$uuid',
          min: -180,
          max: 180,
          divisions: 360,
          defaultValue: isSecondDevice == true
              ? (secondRotate ?? 0 * 180)
              : (rotate ?? 0 * 180),
          onChanged: (val) => updateDeviceRotate?.call(
            val / 180,
          ),
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'horizontal',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: 'DevicePositionRightLeft-$uuid',
          min: -300,
          max: 300,
          divisions: 600,
          defaultValue: isSecondDevice == true
              ? secondDeviceHorizontalPosition ?? 0
              : firstDeviceHorizontalPosition ?? 0,
          onChanged: (val) => updateDevicePossition?.call(
            horizontalPosition: val,
          ),
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'vertical',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: 'DevicePositionTopBottom-$uuid',
          min: -300,
          max: 300,
          divisions: 600,
          defaultValue: isSecondDevice == true
              ? secondDeviceVerticalPosition ?? 0
              : firstDeviceVerticalPosition ?? 0,
          onChanged: (val) => updateDevicePossition?.call(
            verticalPosition: val,
          ),
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}
