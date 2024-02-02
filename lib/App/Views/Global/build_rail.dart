import 'package:flutter/material.dart';
import 'package:flutterpp/Config/app_config.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

class BuildRail extends StatelessWidget {
  final List<Map<String, dynamic>> tabs;
  final int selectedIndex;
  final Function(int) onDestinationSelected;
  const BuildRail({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConfig.rail,
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.background,
        border: Border(
          right: BorderSide(
            width: 1,
            color: Get.theme.colorScheme.primaryContainer,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Get.theme.colorScheme.primaryContainer,
                ),
              ),
            ),
            child: const FlutterLogo(),
          ),
          Expanded(
            child: NavigationRail(
              minWidth: AppConfig.rail * 0.7,
              selectedIndex: selectedIndex,
              onDestinationSelected: (int index) =>
                  onDestinationSelected(index),
              destinations: tabs.map((e) {
                return NavigationRailDestination(
                  padding: const EdgeInsets.all(0),
                  icon: HeroIcon(e['icon'], style: HeroIconStyle.outline),
                  selectedIcon: HeroIcon(e['icon'], style: HeroIconStyle.solid),
                  label: Text(e['title']),
                );
              }).toList(),
            ),
          ),
          IconButton(
            onPressed: () => debugPrint('object'),
            icon: const HeroIcon(
              HeroIcons.informationCircle,
              style: HeroIconStyle.mini,
            ),
            color: Get.theme.colorScheme.secondaryContainer,
          ),
          IconButton(
            onPressed: () => debugPrint('object'),
            icon: const HeroIcon(
              HeroIcons.cog,
              style: HeroIconStyle.mini,
            ),
            color: Get.theme.colorScheme.secondaryContainer,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
