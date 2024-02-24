import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';

class AppWindowConfig {
  // config
  Future<void> config() async {
    // app icon
    String iconPath = GetPlatform.isWindows
        ? 'assets/images/fav_logo.ico'
        : 'assets/images/fav_logo.png';

    final SystemTray systemTray = SystemTray();

    // We first init the systray menu
    await systemTray.initSystemTray(
      title: "",
      toolTip: "FlutterPP",
      iconPath: iconPath,
    );

    // create context menu
    final Menu menu = Menu();
    await menu.buildFrom([
      MenuItemLabel(
        label: 'Show'.capitalize!,
        onClicked: (menuItem) async => await windowManager.show(),
      ),
      MenuItemLabel(
        label: 'minimize'.capitalize!,
        onClicked: (menuItem) async => await windowManager.minimize(),
      ),
      MenuSeparator(),
      MenuItemLabel(
        label: 'bring To Front'.capitalize!,
        onClicked: (menuItem) async {
          await windowManager.setAlwaysOnTop(true);
        },
      ),
      MenuItemLabel(
        label: 'bring To Back'.capitalize!,
        onClicked: (menuItem) async {
          await windowManager.setAlwaysOnTop(false);
        },
      ),
      MenuSeparator(),
      MenuItemLabel(
        label: 'Exit'.capitalize!,
        onClicked: (menuItem) async {
          await windowManager.close();
          await systemTray.destroy();
        },
      ),
    ]);

    systemTray.setContextMenu(menu);

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
