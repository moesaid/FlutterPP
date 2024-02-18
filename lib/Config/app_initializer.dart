import 'dart:io';

import 'package:flutterpp/App/Providers/Local/app_mode.dart';
import 'package:flutterpp/Config/app_config.dart';
import 'package:flutterpp/Config/app_window_config.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class AppInitializer {
  static Future<void> initialize() async {
    // config window
    AppWindowConfig().config();

    // get storage
    await GetStorage.init();

    // supabase
    await Supabase.initialize(
      url: AppConfig().supabaseURL,
      anonKey: AppConfig().supabaseAnonKey,
    );

    // app mode
    await AppMode().init();

    // lunch app on startup
    _lunchAppOnStartup();

    // init local date
    await _initLocalDate();

    // initialize syntax highlighter
    await Highlighter.initialize(['dart', 'yaml', 'sql']);
  }

  static Future<void> _lunchAppOnStartup() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    launchAtStartup.setup(
      appName: packageInfo.appName,
      appPath: Platform.resolvedExecutable,
    );

    bool isEnabled = await launchAtStartup.isEnabled();
    if (!isEnabled) {
      launchAtStartup.enable();
    }
  }

  static _initLocalDate() {
    initializeDateFormatting();
  }
}
