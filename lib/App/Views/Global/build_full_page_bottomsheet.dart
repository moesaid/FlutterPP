import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Global/build_close_button.dart';
import 'package:get/get.dart';

class BuildFullPageBottomSheet extends StatelessWidget {
  const BuildFullPageBottomSheet({
    super.key,
    this.padding,
    this.decoration,
    this.bgColor,
    this.child,
    this.closeWidget,
  });

  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;
  final Color? bgColor;
  final Widget? child, closeWidget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          padding: padding ??
              const EdgeInsets.only(
                top: 40,
                left: 20,
                right: 20,
                bottom: 20,
              ),
          decoration: decoration ??
              BoxDecoration(
                color: bgColor ??
                    Get.theme.scaffoldBackgroundColor.withOpacity(0.9),
              ),
          child: child ??
              Text(
                'Hello world',
                style: Get.textTheme.bodySmall?.copyWith(
                  color: Get.theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: closeWidget ?? const BuildCloseButton(),
        )
      ],
    );
  }
}
