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
  bool? isSecondDevice = false,
  double? firstDeviceRotateInitialValue,
  void Function({
    double? firstDevicePositionTopBottom,
    double? firstDevicePositionRightLeft,
    double? secondDevicePositionTopBottom,
    double? secondDevicePositionRightLeft,
  })? onUpdateDevicePossition,
  void Function(double rotate)? onUpdateFirstDeviceRotate,
  void Function(bool value)? onUpdateFirstDeviceFullSize,
  void Function(Color color)? updateFirstStrokeColor,
  void Function(double width)? updateFirstStrokeWidth,
  void Function(DeviceInfo)? updateDeviceFrame,
  void Function(String img)? onDeviceImageUpload,
  onSecondDeviceImageUpload,
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
      if (isSecondDevice!)
        BuildSliderEnableOption(
          controllerTag: 'deviceEnable-$uuid',
        ),
      const SizedBox(height: 20),
      BuildSidebarOption(
        title: 'Screen',
        rightWidget: BuildSelectImageOption(
          mockupId: mockupId,
          controllerTag: 'devideImage-$uuid',
          callback: (val) {
            if (isSecondDevice) {
              onSecondDeviceImageUpload?.call(val);
            } else {
              onDeviceImageUpload?.call(val);
            }
          },
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'Frame',
        rightWidget: BuildEditFrame(
          controllerTag: 'deviceFrame-$uuid',
          callback: updateDeviceFrame,
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
      const Divider(height: 50),
      const Text(
        'Position',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 20),
      BuildSidebarOption(
        title: 'horizontal',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: 'firstDevicePositionRightLeft-$uuid',
          min: -300,
          max: 300,
          divisions: 600,
          onChanged: (val) => onUpdateDevicePossition?.call(
            firstDevicePositionRightLeft: val,
          ),
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'vertical',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: 'firstDevicePositionTopBottom-$uuid',
          min: -300,
          max: 300,
          divisions: 600,
          onChanged: (val) => onUpdateDevicePossition?.call(
            firstDevicePositionTopBottom: val,
          ),
        ),
      ),
      if (isSecondDevice)
        BuildSidebarOption(
          title: 'horizontal',
          rightWidget: BuildSliderWithValueBox(
            controllerTag: 'secondDevicePositionRightLeft-$uuid',
            min: -300,
            max: 300,
            divisions: 600,
            onChanged: (val) => onUpdateDevicePossition?.call(
              secondDevicePositionRightLeft: val,
            ),
          ),
        ),
      if (isSecondDevice) const SizedBox(height: 10),
      if (isSecondDevice)
        BuildSidebarOption(
          title: 'vertical',
          rightWidget: BuildSliderWithValueBox(
            controllerTag: 'secondDevicePositionTopBottom-$uuid',
            min: -300,
            max: 300,
            divisions: 600,
            onChanged: (val) => onUpdateDevicePossition?.call(
              secondDevicePositionTopBottom: val,
            ),
          ),
        ),
      const SizedBox(height: 20),
    ],
  );
}
