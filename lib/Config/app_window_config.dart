import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AppWindowConfig {
  // config
  void config() {
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
      skipTaskbar: true,
    );

    // show window
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.ensureInitialized();
      await windowManager.show();
      await windowManager.focus();
    });

    // native menu
  }
}
