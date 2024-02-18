import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';

class AppWindowConfig {
  // config
  Future<void> config() async {
    // app icon
    String iconPath = GetPlatform.isWindows
        ? 'assets/images/app_icon.ico'
        : 'assets/images/app_icon.png';

    final SystemTray systemTray = SystemTray();

    // We first init the systray menu
    await systemTray.initSystemTray(
      title: "FlutterPP",
      toolTip: "FlutterPP",
      iconPath: iconPath,
    );

    systemTray.setContextMenu([
      MenuItem(
        label: 'Show',
        onClicked: () async {
          await windowManager.show();
          await windowManager.focus();
        },
      ),
      MenuItem(
        label: 'center',
        onClicked: () async {
          await windowManager.center();
        },
      ),
      MenuItem(
        label: 'Exit',
        onClicked: () async {
          await windowManager.close();
        },
      ),
    ]);

    // handle system tray event
    systemTray.registerSystemTrayEventHandler((eventName) async {
      debugPrint("eventName: $eventName");
      await systemTray.popUpContextMenu();
    });

    // config window
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1280, 800),
      minimumSize: Size(960, 660),
      title: 'Flutter++',
      backgroundColor: Colors.black,
      titleBarStyle: TitleBarStyle.hidden,
      alwaysOnTop: false,
      center: true,
      fullScreen: false,
      skipTaskbar: false,
    );

    // show window
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
}
