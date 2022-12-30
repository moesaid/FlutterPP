import 'package:flutter/material.dart';
import 'package:flutterpp/Config/app_config.dart';
import 'package:get/get.dart';

class BuildSidebar extends StatelessWidget {
  const BuildSidebar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConfig.sidebar,
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.background.withOpacity(0.7),
        border: Border(
          right: BorderSide(
            width: 1,
            color: Get.theme.colorScheme.primaryContainer,
          ),
        ),
      ),
    );
  }
}
