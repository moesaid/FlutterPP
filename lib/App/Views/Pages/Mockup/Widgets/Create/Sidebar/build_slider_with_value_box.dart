import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Global/build_slider.dart';
import 'package:sizer/sizer.dart';

class BuildSliderWithValueBox extends StatelessWidget {
  final String? controllerTag;
  final Function(double)? onChanged;
  const BuildSliderWithValueBox({
    super.key,
    this.controllerTag,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 4.sp,
            vertical: 2.sp,
          ),
          child: const Center(
            child: Text(
              '12',
              style: TextStyle(
                color: Colors.white,
                // fontSize: 13,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: BuildSlider(
            controllerTag: controllerTag,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
