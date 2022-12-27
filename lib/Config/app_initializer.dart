import 'package:flutterpp/App/Providers/Local/app_mode.dart';
import 'package:get_storage/get_storage.dart';
import 'package:window_manager/window_manager.dart';

class AppInitializer {
  static Future<void> initialize() async {
    await windowManager.ensureInitialized();
    await GetStorage.init();

    // app mode
    await AppMode().init();
  }
}
