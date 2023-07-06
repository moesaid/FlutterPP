import 'package:flutter/material.dart';

class BuildSliderWithValueBox extends StatelessWidget {
  const BuildSliderWithValueBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: const Center(
              child: Text(
                '12 px',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Slider(
            max: 50,
            min: 10,
            value: 30,
            onChanged: (val) => print('object'),
          ),
        ),
      ],
    );
  }
}
