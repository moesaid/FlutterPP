import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Global/build_rail.dart';

class BuildLayout extends StatelessWidget {
  final List<Map<String, dynamic>> tabs;
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const BuildLayout({
    Key? key,
    required this.tabs,
    required this.selectedIndex,
    required this.onDestinationSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          BuildRail(
            tabs: tabs,
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) => onDestinationSelected(index),
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: tabs.firstWhere((el) => el['isActive'] == true)['tab'],
            ),
          ),
        ],
      ),
    );
  }
}
