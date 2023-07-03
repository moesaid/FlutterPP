import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildCloseButton extends StatelessWidget {
  final double? iconSize, size;
  final Color? bgColor;

  const BuildCloseButton({
    super.key,
    this.iconSize,
    this.size,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.back(),
      child: Container(
        width: size ?? 35,
        height: size ?? 35,
        decoration: BoxDecoration(
          color: bgColor ?? Get.theme.colorScheme.primaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
        ),
        child: Center(
          child: Icon(
            Icons.close_rounded,
            color: Colors.white,
            size: iconSize ?? 20,
          ),
        ),
      ),
    );
  }
}
