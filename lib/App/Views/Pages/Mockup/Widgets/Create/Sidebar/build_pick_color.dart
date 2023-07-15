import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/pickup_color_controller.dart';
import 'package:get/get.dart';

class BuildPickColor extends GetView<PickupColorController> {
  final Function(Color)? onColorChangedCallback;

  const BuildPickColor({
    this.onColorChangedCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PickupColorController>(
      init: PickupColorController(),
      builder: (_) {
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () async {
                  await colorPickerDialog(
                    context: context,
                    customColorSwatchesAndNames: {},
                    dialogPickerColor: controller.dialogPickerColor,
                    onColorChanged: (Color color) => controller.onColorChanged(
                      color: color,
                      callback: onColorChangedCallback,
                    ),
                  );
                },
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: controller.screenPickerColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    '10%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

Future<bool> colorPickerDialog({
  required Color dialogPickerColor,
  required void Function(Color) onColorChanged,
  required Map<ColorSwatch<Object>, String> customColorSwatchesAndNames,
  required BuildContext context,
}) async {
  return ColorPicker(
    // Use the dialogPickerColor as start color.
    color: dialogPickerColor,
    // Update the dialogPickerColor using the callback.
    onColorChanged: onColorChanged,
    width: 40,
    height: 40,
    borderRadius: 4,
    spacing: 10,
    runSpacing: 10,
    wheelDiameter: 200,
    heading: const Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text('Select color'),
    ),
    wheelSubheading: const Padding(
      padding: EdgeInsets.all(10),
      child: Text('Selected color and its shades'),
    ),
    showMaterialName: false,
    showColorName: false,
    showColorCode: false,
    enableTonalPalette: true,
    enableOpacity: true,
    wheelSquarePadding: 20,
    copyPasteBehavior: const ColorPickerCopyPasteBehavior(
      longPressMenu: false,
    ),
    // materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
    // colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
    // colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
    pickersEnabled: const <ColorPickerType, bool>{
      ColorPickerType.both: false,
      ColorPickerType.primary: false,
      ColorPickerType.accent: false,
      ColorPickerType.bw: false,
      ColorPickerType.custom: false,
      ColorPickerType.wheel: true,
    },
    customColorSwatchesAndNames: customColorSwatchesAndNames,
    actionButtons: const ColorPickerActionButtons(
      closeButton: true,
      dialogActionButtons: false,
    ),
  ).showPickerDialog(
    context,
    actionsPadding: const EdgeInsets.only(right: 18, bottom: 18),
    transitionBuilder: (
      BuildContext context,
      Animation<double> a1,
      Animation<double> a2,
      Widget widget,
    ) {
      final double curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(
          0.0,
          curvedValue * 200,
          0.0,
        ),
        child: Opacity(
          opacity: a1.value,
          child: widget,
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 400),
    constraints: const BoxConstraints(
      minHeight: 460,
      minWidth: 300,
      maxWidth: 320,
    ),
  );
}
