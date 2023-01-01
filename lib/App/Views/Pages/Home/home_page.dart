import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Home/home_controller.dart';
import 'package:flutterpp/App/Views/Global/build_layout.dart';
import 'package:flutterpp/App/Views/Global/build_loading_page.dart';
import 'package:flutterpp/App/Views/Pages/Team/no_team_page.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: controller.isLoading
                ? const BuildLoadingPage()
                : controller.isInTeam
                    ? BuildLayout(
                        tabs: controller.tabs,
                        selectedIndex: controller.selectedTab,
                        onDestinationSelected: (index) =>
                            controller.changeTab(index),
                      )
                    : const NoTeamPage(),
          ),
        );
      },
    );
  }
}
