import 'dart:convert';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/Config/Bindings/app_binding.dart';
import 'package:flutterpp/Config/app_initializer.dart';
import 'package:flutterpp/Config/app_theme.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
// http
import 'package:http/http.dart' as http;
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
                final data = await http.get(
                  Uri.parse(
                    "https://api.github.com/repos/moesaid/flutterpp/releases/latest",
                  ),
                );
                return jsonDecode(data.body)["tag_name"];
              },
              getBinaryUrl: (latestVersion) async {
                // Here you provide the link to the binary the user should download. Make sure it is the correct one for the platform!

                // Get the platform extension
                String platformExt, operatingSystem;
                if (GetPlatform.isMacOS) {
                  platformExt = "dmg";
                  operatingSystem = "macos";
                } else if (GetPlatform.isWindows) {
                  platformExt = "exe";
                  operatingSystem = "windows";
                } else if (GetPlatform.isLinux) {
                  platformExt = "AppImage";
                  operatingSystem = "linux";
                } else {
                  throw UnsupportedError("Unsupported platform");
                }

                // Make sure that this link includes the platform extension with which to save your binary.
                // If you use https://exapmle.com/latest/macos for instance then you need to create your own file using `getDownloadFileLocation`
                return "https://github.com/moesaid/flutterpp/releases/download/$version/updat-$operatingSystem-$version.$platformExt";
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
