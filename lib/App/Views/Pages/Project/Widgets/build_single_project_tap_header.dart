import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildSingleProjectTapHeader extends StatelessWidget {
  const BuildSingleProjectTapHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      dividerColor: Get.theme.colorScheme.secondaryContainer,
      indicatorColor: Get.theme.primaryColorLight,
      labelColor: Get.theme.primaryColorLight,
      unselectedLabelColor: Get.theme.colorScheme.onBackground,
      indicatorSize: TabBarIndicatorSize.label,
      isScrollable: true,
      enableFeedback: true,
      tabs: [
        Tab(text: 'Code Gen'.capitalize!),
        Tab(text: 'wiki'.capitalize!),
        Tab(text: 'files'.capitalize!),
      ],
    );
  }
}
