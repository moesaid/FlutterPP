import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Global/app_update_controller.dart';
import 'package:flutterpp/App/Views/Global/build_rail.dart';
import 'package:flutterpp/App/Views/Global/build_windows_buttons.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:updat/theme/chips/floating_with_silent_download.dart';
import 'package:updat/updat.dart';
import 'package:window_manager/window_manager.dart';

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
              if (GetPlatform.isWindows)
                DragToMoveArea(child: BuildLayoutAppbar(tabs: tabs)),
              if (GetPlatform.isMacOS) BuildLayoutAppbar(tabs: tabs),
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
            bottom: 10.spa,
            left: 10.spa,
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
      builder: (controller) {
        if (controller.isLoading ||
            controller.currentVersion.isEmpty ||
            controller.lastVersion.isEmpty) {
          return const SizedBox.shrink();
        }

        return UpdatWidget(
          currentVersion: controller.currentVersion,
          getLatestVersion: controller.getLatestVersion,
          getBinaryUrl: controller.getBinaryUrl,
          appName: "FlutterPP",
          updateChipBuilder: floatingExtendedChipWithSilentDownload,
        );
      },
    );
  }
}

class BuildLayoutAppbar extends StatelessWidget {
  final List<Map<String, dynamic>> tabs;
  const BuildLayoutAppbar({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: context.width,
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.surface.withValues(alpha: 0.2),
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Get.theme.colorScheme.primaryContainer,
          ),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            tabs
                .firstWhere((el) => el['isActive'] == true)['title']
                .toString()
                .capitalizeFirst!,
            style: Get.textTheme.titleSmall!.copyWith(
              fontSize: 12,
            ),
          ),
          if (GetPlatform.isWindows)
            const Positioned(
              right: 0,
              child: BuildWindowsButtons(),
            ),
        ],
      ),
    );
  }
}
