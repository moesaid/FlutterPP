import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildCloseButton extends StatelessWidget {
  final double? iconSize, size;
  final Color? bgColor;
  final void Function()? onTap;

  const BuildCloseButton({
    super.key,
    this.iconSize,
    this.size,
    this.bgColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Get.back(),
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
