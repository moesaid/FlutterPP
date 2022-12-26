import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Pages/Auth/splash_page.dart';
import 'package:flutterpp/Config/app_binding.dart';
import 'package:flutterpp/Config/app_initializer.dart';
import 'package:flutterpp/Config/app_theme.dart';
import 'package:flutterpp/Config/app_window_config.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize services
  await AppInitializer.initialize();

  // config window
  AppWindowConfig().config();

  // runApp
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter ++',
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      theme: AppTheme().lightThemeData(),
      darkTheme: AppTheme().darkThemeData(),
      themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const DragToMoveArea(child: SplashPage()),
    );
  }
}
