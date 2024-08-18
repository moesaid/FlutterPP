import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class BuildSingleProjectNoPathState extends StatelessWidget {
  const BuildSingleProjectNoPathState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/lottie/empty_box.json',
          height: 200,
          width: 200,
        ),
        SizedBox(height: 2.spa),
        Text(
          'No local path found - your code\'s gone on a cosmic vacation! 🚀🤷',
          style: Get.textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 1.spa),
        Text(
          'create a new project or load an existing one',
          style: Get.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
