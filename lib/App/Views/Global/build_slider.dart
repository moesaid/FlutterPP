import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/Micro/slider_option_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildSlider extends StatelessWidget {
  final double? min, max, defaultValue;
  final String? controllerTag;
  final int? divisions;
  final void Function(double)? onChanged;
  const BuildSlider({
    super.key,
    this.controllerTag,
    this.min,
    this.max,
    this.defaultValue,
    this.onChanged,
    this.divisions,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SliderOptionController>(
      init: SliderOptionController(),
      tag: controllerTag,
      initState: (_) {},
      didChangeDependencies: (state) {
        if (defaultValue != null && defaultValue != 0) {
          state.controller?.onChange(value: defaultValue ?? 0);
        }
      },
      builder: (_) {
        final double localMax = max ?? 100;
        final double localMin = min ?? 0;

        return SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 5.0,
            trackShape: const RoundedRectSliderTrackShape(),
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 8.0,
              pressedElevation: 4.0,
            ),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 12.0),
            tickMarkShape: const RoundSliderTickMarkShape(),
            inactiveTickMarkColor: Colors.white,
            valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
            valueIndicatorColor: Colors.black,
            valueIndicatorTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 6.sp,
            ),
          ),
          child: Slider(
            min: (localMin > localMax ? localMax - localMax / 2 : localMin),
            max: localMax,
            divisions: divisions ?? 20,
            activeColor: Get.theme.primaryColor,
            inactiveColor: Get.theme.colorScheme.onBackground.withOpacity(0.1),
            thumbColor: Get.theme.primaryColor,
            value: _.sliderValue > localMax ? localMax : _.sliderValue,
            label: _.sliderValue.toStringAsFixed(0),
            onChanged: (double value) {
              _.onChange(
                value: value,
                callback: onChanged,
              );
            },
          ),
        );
      },
    );
  }
}
