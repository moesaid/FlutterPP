import 'package:flutterpp/App/Providers/Local/app_mode.dart';
import 'package:flutterpp/Config/app_config.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:window_manager/window_manager.dart';

class AppInitializer {
  static Future<void> initialize() async {
    await windowManager.ensureInitialized();
    await GetStorage.init();

    await Supabase.initialize(
      url: AppConfig().supabaseURL,
      anonKey: AppConfig().supabaseAnonKey,
    );

    // app mode
    await AppMode().init();
  }
}
