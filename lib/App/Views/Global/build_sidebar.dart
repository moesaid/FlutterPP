import 'package:flutter/material.dart';
import 'package:flutterpp/Config/app_config.dart';
import 'package:get/get.dart';

class BuildSidebar extends StatelessWidget {
  final Widget? child;
  const BuildSidebar({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConfig.sidebar,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.background.withOpacity(0.7),
        border: Border(
          right: BorderSide(
            width: 1,
            color: Get.theme.colorScheme.primaryContainer,
          ),
        ),
      ),
      child: child ?? const Text('sidebar'),
    );
  }
}
