import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/Config/Bindings/app_binding.dart';
import 'package:flutterpp/Config/app_initializer.dart';
import 'package:flutterpp/Config/app_theme.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize services
  await AppInitializer.initialize();

  // runApp
  await AppInitializer.initSentry(() async {
    runApp(DefaultAssetBundle(
      bundle: SentryAssetBundle(),
      child: const MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          navigatorObservers: [SentryNavigatorObserver()],
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
