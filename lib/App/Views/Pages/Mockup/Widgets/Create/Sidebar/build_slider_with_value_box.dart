import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Global/build_slider.dart';

class BuildSliderWithValueBox extends StatelessWidget {
  final String? controllerTag;
  final double? defaultValue;
  final double? min;
  final double? max;
  final int? divisions;
  final Function(double)? onChanged;
  const BuildSliderWithValueBox({
    super.key,
    this.controllerTag,
    this.onChanged,
    this.defaultValue,
    this.min,
    this.max,
    this.divisions,
  });

  @override
  Widget build(BuildContext context) {
    return BuildSlider(
      min: min ?? 0,
      max: max ?? 50,
      divisions: divisions ?? 50,
      onChanged: onChanged,
      defaultValue: defaultValue ?? 0,
      controllerTag: controllerTag,
    );
  }
}
