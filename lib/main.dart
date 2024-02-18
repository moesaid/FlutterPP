// import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/Config/Bindings/app_binding.dart';
import 'package:flutterpp/Config/app_initializer.dart';
import 'package:flutterpp/Config/app_theme.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:updat/updat_window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize services
  await AppInitializer.initialize();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String version = packageInfo.version;

  // runApp
  runApp(MyApp(version: version));
}

class MyApp extends StatelessWidget {
  final String version;

  const MyApp({super.key, required this.version});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'Flutter ++',
          debugShowCheckedModeBanner: false,
          theme: AppTheme().lightThemeData(),
          darkTheme: AppTheme().darkThemeData(),
          themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialBinding: AppBinding(),
          getPages: AppPages.pages,
          defaultTransition: Transition.native,
          builder: (context, child) {
            return UpdatWindowManager(
              currentVersion: version,
              getLatestVersion: () async {
                // Here you should fetch the latest version. It must be semantic versioning for update detection to work properly.
                return "1.0.1";
              },
              getBinaryUrl: (latestVersion) async {
                // Here you provide the link to the binary the user should download. Make sure it is the correct one for the platform!
                return "https://github.com/latest/release/bin.exe";
              },
              // Lastly, enter your app name so we know what to call your files.
              appName: "FlutterPP",

              child: child ?? const SizedBox.shrink(),
            );
          },
          localizationsDelegates: const [
            AppFlowyEditorLocalizations.delegate,
            FormBuilderLocalizations.delegate,
            FormBuilderLocalizationsImpl.delegate,
          ],
          supportedLocales:
              AppFlowyEditorLocalizations.delegate.supportedLocales,
        );
      },
    );
  }
}
