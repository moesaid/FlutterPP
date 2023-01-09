import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectSingleController extends GetxController {
  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _selectedTab = 0.obs;
  int get selectedTab => _selectedTab.value;

  final _tabs = [
    {
      'icon': Icons.home,
      'title': 'Home',
      'page': const Text('home'),
      'isActive': true,
    },
    {
      'icon': Icons.settings,
      'title': 'Settings',
      'page': const Text('settings'),
      'isActive': false,
    },
    {
      'icon': Icons.people,
      'title': 'Members',
      'page': const Text('members'),
      'isActive': false,
    },
    {
      'icon': Icons.info,
      'title': 'About',
      'page': const Text('about'),
      'isActive': false,
    },
  ].obs;
  List<Map<String, dynamic>> get tabs => _tabs;

  // update tabs
  void updateTabs(int index) {
    for (var el in _tabs) {
      el['isActive'] = false;
    }
    _selectedTab.value = index;
    _tabs[index]['isActive'] = true;
    update();
  }
}
