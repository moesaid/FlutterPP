import 'package:flutterpp/Config/app_appwrite_client.dart';
import 'package:window_manager/window_manager.dart';

class AppInitializer {
  static Future<void> initialize() async {
    await windowManager.ensureInitialized();
    AppwriteClient().initClient();
  }
}
