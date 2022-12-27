import 'package:flutter/material.dart';
import 'package:flutterpp/Config/app_config.dart';
import 'package:get/get.dart';

class BuildLayout extends StatelessWidget {
  const BuildLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const BuildRail(),
          // const BuildSidebar(),
          Expanded(
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

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

class BuildRail extends StatelessWidget {
  const BuildRail({
    Key? key,
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
              selectedIndex: 1,
              onDestinationSelected: (int index) {
                print(index);
              },
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.favorite_border),
                  selectedIcon: Icon(Icons.favorite),
                  label: Text('First'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.bookmark_border),
                  selectedIcon: Icon(Icons.book),
                  label: Text('Second'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.star_border),
                  selectedIcon: Icon(Icons.star),
                  label: Text('Third'),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              print('object');
            },
            icon: const Icon(Icons.keyboard_arrow_right),
            color: Get.theme.colorScheme.secondaryContainer,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
