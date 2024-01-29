import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BuildOverlay extends StatelessWidget {
  const BuildOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LoadingAnimationWidget.staggeredDotsWave(
          color: Get.theme.colorScheme.secondary,
          size: 100,
        ),
      ],
    );
  }
}
