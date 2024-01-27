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
  bool? showStroke,
  bool? showShadow,
  Color? strokeColor,
  double? strokeWidth,
  Color? shadowColor,
  double? shadowBlur,
  double? shadowOffsetX,
  double? shadowOffsetY,
  double? verticalPosition,
  double? horizontalPosition,
  double? scale,
  void Function(double scale, {bool? isSecondDevice})? updateDeviceScale,
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
  void Function(bool value, {bool? isSecondDevice})?
      updateDeviceShadowVisibility,
  bool? showDevice,
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
      BuildSliderEnableOption(
        title: 'Enable',
        initialValue: showDevice,
        controllerTag: 'deviceEnable-bool-$uuid',
        onToggle: (val) => updateShowDevice?.call(
          val,
          isSecondDevice: isSecondDevice,
        ),
      ),
      BuildSliderEnableOption(
        title: 'Frame',
        initialValue: showFrame,
        controllerTag: 'deviceFrame-bool-$uuid',
        onToggle: (val) => updateShowDeviceFrame?.call(
          val,
          isSecondDevice: isSecondDevice,
        ),
      ),
      const SizedBox(height: 20),
      BuildSidebarOption(
        title: 'Screen',
        rightWidget: BuildSelectImageOption(
          mockupId: mockupId,
          controllerTag: 'devideImage-$uuid',
          callback: (val) {
            onDeviceImageUpload?.call(
              val,
              isSecondDevice: isSecondDevice,
            );
          },
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'Frame',
        rightWidget: BuildEditFrame(
          controllerTag: 'deviceFrame-$uuid',
          initialValue: initalFrame,
          callback: (val) => updateDeviceFrame?.call(
            val,
            isSecondDevice: isSecondDevice,
          ),
        ),
      ),
      const SizedBox(height: 20),
      BuildSidebarOption(
        title: 'Size',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: 'deviceSize-$uuid',
          min: 0.5,
          max: 2,
          divisions: 40,
          fractionDigits: 2,
          defaultValue: scale ?? 1,
          onChanged: (val) => updateDeviceScale?.call(
            val,
            isSecondDevice: isSecondDevice,
          ),
        ),
      ),
      const SizedBox(height: 10),
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
        onToggle: (val) => updateDeviceStrokeVisibility?.call(
          val,
          isSecondDevice: isSecondDevice,
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'Color',
        rightWidget: BuildPickColor(
          controllerTag: 'deviceStrokeColor-$uuid',
          initialColor: strokeColor ?? Colors.black,
          onColorChangedCallback: (val) => updateStrokeColor?.call(
            val,
            isSecondDevice: isSecondDevice,
          ),
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
          onChanged: (val) => updateStrokeWidth?.call(
            val,
            isSecondDevice: isSecondDevice,
          ),
        ),
      ),
      const Divider(height: 50),
      const Text(
        'Shadow',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 20),
      BuildSliderEnableOption(
        title: 'Enable',
        initialValue: showShadow,
        controllerTag: 'deviceShadowEnable-bool-$uuid',
        onToggle: (val) => updateDeviceShadowVisibility?.call(
          val,
          isSecondDevice: isSecondDevice,
        ),
      ),
      BuildSidebarOption(
        title: 'color',
        rightWidget: BuildPickColor(
          initialColor: shadowColor ?? Colors.black,
          controllerTag: 'deviceShadowColor-$uuid',
          onColorChangedCallback: (val) => updateShadowColor?.call(
            val,
            isSecondDevice: isSecondDevice,
          ),
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'blur',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: 'deviceShadowblur-$uuid',
          min: 0,
          max: 40,
          divisions: 40,
          defaultValue: shadowBlur ?? 0,
          onChanged: (val) => updateDeviceShadowBlur?.call(
            val,
            isSecondDevice: isSecondDevice,
          ),
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'x offset',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: 'deviceShadowXOffset-$uuid',
          min: -40,
          max: 40,
          divisions: 80,
          defaultValue: shadowOffsetX ?? 0,
          onChanged: (val) => updateDeviceShadowXOffset?.call(
            val,
            isSecondDevice: isSecondDevice,
          ),
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'y offset',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: 'deviceShadowYOffset-$uuid',
          min: -40,
          max: 40,
          divisions: 80,
          defaultValue: shadowOffsetY ?? 0,
          onChanged: (val) => updateDeviceShadowYOffset?.call(
            val,
            isSecondDevice: isSecondDevice,
          ),
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
          defaultValue: ((rotate ?? 0) * 180),
          onChanged: (val) => updateDeviceRotate?.call(
            val / 180,
            isSecondDevice: isSecondDevice,
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
          defaultValue: horizontalPosition ?? 0,
          onChanged: (val) {
            if (isSecondDevice == true) {
              updateDevicePossition?.call(
                secondHorizontalPosition: val,
              );
            } else {
              updateDevicePossition?.call(
                horizontalPosition: val,
              );
            }
          },
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
            defaultValue: verticalPosition ?? 0,
            onChanged: (val) {
              if (isSecondDevice == true) {
                updateDevicePossition?.call(
                  secondVerticalPosition: val,
                );
              } else {
                updateDevicePossition?.call(
                  verticalPosition: val,
                );
              }
            }),
      ),
      const SizedBox(height: 20),
    ],
  );
}
