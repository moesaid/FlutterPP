import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildCloseButton extends StatelessWidget {
  const BuildCloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.back(),
      child: Container(
        width: 35,
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.primaryContainer,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.close_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
