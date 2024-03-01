import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Global/build_appbar_platform_button.dart';
import 'package:flutterpp/App/Views/Global/build_hover_widget.dart';
import 'package:flutterpp/Config/app_window_config.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

class BuildWindowsButtons extends StatelessWidget {
  const BuildWindowsButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final win = AppWindowConfig().getWindowManager;
    final systemTray = AppWindowConfig().getSystemTray;

    return BuildHoverWidget(
      child: (hover) => Row(
        children: [
          // BuildAppbarPlatformButton(
          //   size: 12,
          //   hover: hover,
          //   icon: HeroIcons.arrowsPointingOut,
          //   onTap: () async {
          //     await win.setFullScreen(true);
          //   },
          //   afterHoverColor: Colors.green,
          //   beforeHoverColor:
          //       Get.theme.colorScheme.onBackground.withOpacity(0.4),
          // ),
          // const SizedBox(width: 6),
          BuildAppbarPlatformButton(
            size: 12,
            hover: hover,
            icon: HeroIcons.minus,
            onTap: () async => await win.minimize(),
            afterHoverColor: Colors.yellow,
            beforeHoverColor:
                Get.theme.colorScheme.onBackground.withOpacity(0.4),
          ),
          const SizedBox(width: 6),
          BuildAppbarPlatformButton(
            size: 12,
            hover: hover,
            icon: HeroIcons.xMark,
            afterHoverColor: Colors.red,
            onTap: () async {
              await win.close();
              await systemTray.destroy();
            },
            beforeHoverColor:
                Get.theme.colorScheme.onBackground.withOpacity(0.4),
          ),
          const SizedBox(width: 6),
        ],
      ),
    );
  }
}
