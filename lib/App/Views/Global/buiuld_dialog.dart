import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildDefultDialog extends StatelessWidget {
  final Widget? child;
  final double? height, width;
  final EdgeInsetsGeometry? padding;
  const BuildDefultDialog({
    super.key,
    this.child,
    this.height,
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        height: height ?? 500,
        width: width ?? 500,
        padding: padding ?? const EdgeInsets.all(20),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: child ??
            const Center(
              child: Text('Modal'),
            ),
      ),
    );
  }
}
