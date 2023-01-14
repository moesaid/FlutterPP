import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildDialog extends StatelessWidget {
  final Color? backgroundColor;
  final double? height, width;
  final Widget? child;
  const BuildDialog({
    Key? key,
    this.backgroundColor,
    this.height,
    this.width,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: Get.theme.dialogBackgroundColor.withOpacity(0.5),
          child: GestureDetector(
            onTap: () => Get.back(),
          ),
        ),
        Container(
          height: 300,
          width: 500,
          decoration: BoxDecoration(
            color: Get.theme.dialogBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: child ??
                const Center(
                  child: Text('More Button Clicked'),
                ),
          ),
        ),
      ],
    );
  }
}
