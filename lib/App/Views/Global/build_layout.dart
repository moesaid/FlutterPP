import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Global/app_update_controller.dart';
import 'package:flutterpp/App/Views/Global/build_rail.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:updat/theme/chips/floating_with_silent_download.dart';
import 'package:updat/updat.dart';

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
      body: Stack(
        children: [
          Column(
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
                        child: tabs
                            .firstWhere((el) => el['isActive'] == true)['tab'],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10.sp,
            left: 10.sp,
            child: const BuildAppUpdateWidget(),
          ),
        ],
      ),
    );
  }
}

class BuildAppUpdateWidget extends StatelessWidget {
  const BuildAppUpdateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppUpdateController>(
      init: AppUpdateController(),
      initState: (_) {},
      builder: (_) {
        if (_.isLoading || _.currentVersion.isEmpty || _.lastVersion.isEmpty) {
          return const SizedBox.shrink();
        }

        return UpdatWidget(
          currentVersion: _.currentVersion,
          getLatestVersion: _.getLatestVersion,
          getBinaryUrl: _.getBinaryUrl,
          appName: "FlutterPP",
          updateChipBuilder: floatingExtendedChipWithSilentDownload,
        );
      },
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
