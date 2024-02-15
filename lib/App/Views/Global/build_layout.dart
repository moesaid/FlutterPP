import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Global/build_rail.dart';
import 'package:get/get.dart';

class BuildLayout extends StatelessWidget {
  final List<Map<String, dynamic>> tabs;
  final int selectedIndex;
  final Function(int) onDestinationSelected;
  final VoidCallback onLogout;

  const BuildLayout({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BuildMacAppbar(tabs: tabs),
          Expanded(
            child: Row(
              children: [
                BuildRail(
                  tabs: tabs,
                  selectedIndex: selectedIndex,
                  onLogout: onLogout,
                  onDestinationSelected: (index) =>
                      onDestinationSelected(index),
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child:
                        tabs.firstWhere((el) => el['isActive'] == true)['tab'],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BuildMacAppbar extends StatelessWidget {
  final List<Map<String, dynamic>> tabs;
  const BuildMacAppbar({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: context.width,
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.background.withOpacity(0.2),
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Get.theme.colorScheme.primaryContainer,
          ),
        ),
      ),
      child: Center(
        child: Text(
          tabs
              .firstWhere((el) => el['isActive'] == true)['title']
              .toString()
              .capitalizeFirst!,
          style: Get.textTheme.titleSmall!.copyWith(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
