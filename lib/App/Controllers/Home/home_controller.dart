import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _tabs = [
    {
      'title': 'dashboard',
      'icon': Icons.dashboard,
      'isActive': true,
      'tab': const Text('dashboard'),
    },
    {
      'title': 'home',
      'icon': Icons.home,
      'isActive': false,
      'tab': const Text('home'),
    },
  ].obs;

  List<Map<String, dynamic>> get tabs => _tabs;

  final _selectedTab = 0.obs;
  int get selectedTab => _selectedTab.value;

  // change tab
  void changeTab(int index) {
    for (var element in _tabs) {
      element['isActive'] = false;
    }
    _tabs[index]['isActive'] = true;
    _selectedTab.value = index;
    update();
  }
}
