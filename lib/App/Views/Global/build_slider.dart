import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/Micro/slider_option_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildSlider extends StatelessWidget {
  final double? min, max, defaultValue;
  final String? controllerTag;
  final int? divisions, fractionDigits;
  final String? blockedMessage;
  final bool? isBlocked;
  final void Function(double)? onChanged;
  const BuildSlider({
    super.key,
    this.controllerTag,
    this.min,
    this.max,
    this.defaultValue,
    this.onChanged,
    this.divisions,
    this.isBlocked,
    this.blockedMessage,
    this.fractionDigits,
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
        final double localValue = _.sliderValue > localMax
            ? localMax
            : _.sliderValue < localMin
                ? localMin
                : _.sliderValue;

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
              fontSize: 6.spa,
            ),
          ),
          child: Slider(
            min: (localMin > localMax ? localMax - localMax / 2 : localMin),
            max: localMax,
            divisions: divisions ?? 20,
            activeColor: Get.theme.primaryColor,
            inactiveColor: Get.theme.colorScheme.onBackground.withOpacity(0.1),
            thumbColor: Get.theme.primaryColor,
            value: localValue,
            label: localValue.toStringAsFixed(fractionDigits ?? 0),
            onChanged: (double value) {
              if (isBlocked == true) {
                Get.snackbar(
                  'Blocked',
                  blockedMessage ?? 'This option is blocked',
                  backgroundColor: Get.theme.colorScheme.error,
                  colorText: Get.theme.colorScheme.onError,
                );
                return;
              }

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
