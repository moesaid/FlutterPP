import 'package:flutter/material.dart';
import 'package:flutterpp/App/Services/Auth/auth_services.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

class HomeController extends GetxController {
  final _tabs = [
    {
      'title': 'dashboard',
      'icon': HeroIcons.home,
      'isActive': true,
      'tab': ElevatedButton(
        onPressed: () async {
          await AuthServices().signOut();
        },
        child: const Text('data'),
      ),
    },
    {
      'title': 'projects',
      'icon': HeroIcons.squaresPlus,
      'isActive': false,
      'tab': const Text('projects'),
    },
    {
      'title': 'chat',
      'icon': HeroIcons.chatBubbleOvalLeftEllipsis,
      'isActive': false,
      'tab': const Text('chat'),
    },
    {
      'title': 'invoices',
      'icon': HeroIcons.banknotes,
      'isActive': false,
      'tab': const Text('invoices'),
    },
    {
      'title': 'time tracking',
      'icon': HeroIcons.clock,
      'isActive': false,
      'tab': const Text('time tracking'),
    },
    {
      'title': 'scrum',
      'icon': HeroIcons.rectangleStack,
      'isActive': false,
      'tab': const Text('scrum'),
    },
    {
      'title': 'witeboard',
      'icon': HeroIcons.paintBrush,
      'isActive': false,
      'tab': const Text('witeboard'),
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
