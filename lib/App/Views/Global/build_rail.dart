import 'package:flutter/material.dart';
import 'package:flutterpp/Config/app_config.dart';
import 'package:get/get.dart';

class BuildRail extends StatelessWidget {
  final List<Map<String, dynamic>> tabs;
  final int selectedIndex;
  final Function(int) onDestinationSelected;
  const BuildRail({
    Key? key,
    required this.tabs,
    required this.selectedIndex,
    required this.onDestinationSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              minWidth: AppConfig.rail,
              selectedIndex: selectedIndex,
              labelType: NavigationRailLabelType.none,
              onDestinationSelected: (int index) =>
                  onDestinationSelected(index),
              destinations: tabs.map((e) {
                return NavigationRailDestination(
                  icon: Icon(e['icon']),
                  selectedIcon: Icon(e['icon']),
                  label: Text(e['title']),
                );
              }).toList(),
            ),
          ),
          IconButton(
            onPressed: () {
              print('object');
            },
            icon: const Icon(Icons.settings),
            color: Get.theme.colorScheme.secondaryContainer,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
