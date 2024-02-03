import 'dart:io';

import 'package:flutterpp/Helpers/text_helper.dart';

class FileGenGetxProvider {
  // remove Test folder
  Future<void> removeTestFolder(String path) async {
    if (Directory('$path/test').existsSync()) {
      Directory('$path/test').deleteSync(recursive: true);
    }
  }

  // generate main
  Future<void> mainGen(String nameSpace, String path) async {
    String content = '''
    import 'package:flutter/material.dart';
    import 'package:get/get.dart';
    import 'package:$nameSpace/Config/Bindings/app_binding.dart';
    import 'package:$nameSpace/Config/Exernal/app_initializer.dart';
    import 'package:$nameSpace/Config/Theme/app_theme.dart';
    import 'package:$nameSpace/Routes/app_pages.dart';

    Future<void> main() async {
      WidgetsFlutterBinding.ensureInitialized();

      // initialize services
      await AppInitializer.initialize();

      // runApp
      runApp(const MyApp());
    }

    class MyApp extends StatelessWidget {
      const MyApp({super.key});

      @override
      Widget build(BuildContext context) {
        return GetMaterialApp(
          title: '${nameSpace.toPascalCase()}',
          debugShowCheckedModeBanner: false,
          theme: AppTheme().lightThemeData(),
          darkTheme: AppTheme().darkThemeData(),
          themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialBinding: AppBinding(),
          getPages: AppPages.pages,
          defaultTransition: Transition.native,
        );
      }
    }
    ''';

    // remoev main if exists
    if (File('$path/lib/main.dart').existsSync()) {
      File('$path/lib/main.dart').deleteSync();
    }

    // create file
    File file = File('$path/lib/main.dart');

    // write to file
    file.writeAsStringSync(content);
  }

  // create controller
  Future<void> controllerGen(String name, String path) async {
    String content = '''import 'package:get/get.dart';class
        ${name.toPascalCase()}Controller extends GetxController {}''';

    // create file
    File file = File('$path/${name.toSnakeCase()}_controller.dart');

    // write to file
    file.writeAsStringSync(content);
  }

  // create page
  Future<void> pageGen(
    String nameSpace,
    String name,
    String path, {
    String? custom,
  }) async {
    String content = '''
    import 'package:flutter/material.dart';
    import 'package:get/get.dart';
    import 'package:$nameSpace/App/Controllers/${(custom?.toPascalCase() ?? name.toPascalCase())}/${name.toSnakeCase()}_controller.dart';


    class ${name.toPascalCase()}Page extends GetView<${name.toPascalCase()}Controller> {
      const ${name.toPascalCase()}Page({super.key});

      @override
      Widget build(BuildContext context) {
        return GetBuilder<${name.toPascalCase()}Controller>(
          init: ${name.toPascalCase()}Controller(),
          initState: (_) {},
          builder: (_) {
            return Scaffold(
              appBar: AppBar(title: const Text('${name.toPascalCase()} Page')),
              body: const SafeArea(child: Text('${name.toPascalCase()} Controller')),
            );
          },
        );
      }
    }
    ''';

    // create file
    File file = File('$path/${name.toSnakeCase()}_page.dart');

    // write to file
    file.writeAsStringSync(content);
  }

  // create binding
  Future<void> bindingGen(String nameSpace, String path) async {
    String content = '''
    import 'package:get/get.dart';
    import 'package:$nameSpace/App/Controllers/Counter/counter_controller.dart';
    import 'package:$nameSpace/App/Controllers/Home/home_controller.dart';
    import 'package:$nameSpace/App/Controllers/Auth/splash_controller.dart';

    class AppBinding implements Bindings {
    @override
    void dependencies() {
        Get
        ..lazyPut<SplashController>(() => SplashController())
        ..lazyPut<CounterController>(() => CounterController())
        ..lazyPut<HomeController>(() => HomeController());
      }
    }
    ''';

    // create file
    File file = File('$path/app_binding.dart');

    // write to file
    file.writeAsStringSync(content);
  }

  // create app pages
  Future<void> appPagesGen(String nameSpace, String path) async {
    String content = '''
    import 'package:get/get.dart';
    import 'package:$nameSpace/App/Views/Pages/Auth/splash_page.dart';
    import 'package:$nameSpace/App/Views/Pages/Counter/counter_page.dart';
    import 'package:$nameSpace/App/Views/Pages/Home/home_page.dart';

    part 'app_routes.dart';

    class AppPages {
      static final pages = [
        GetPage(
          name: AppRoutes.SPLASH,
          page: () => const SplashPage(),
        ),
        GetPage(
          name: AppRoutes.HOME,
          page: () => const HomePage(),
        ),
        GetPage(
          name: AppRoutes.COUNTER,
          page: () => const CounterPage(),
        ),
      ];
    }
    ''';

    // create file
    File file = File('$path/app_pages.dart');

    // write to file
    file.writeAsStringSync(content);
  }

  // app routes
  Future<void> appRoutesGen(String path) async {
    String content = '''
    // ignore_for_file: constant_identifier_names
    part of 'app_pages.dart';
    class AppRoutes {
      static const SPLASH = '/';
      static const HOME = '/home';
      static const COUNTER = '/counter';
    }
    ''';

    // create file
    File file = File('$path/app_routes.dart');

    // write to file
    file.writeAsStringSync(content);
  }

  // app initializer
  Future<void> appInitializerGen(String path) async {
    String content = '''
    import 'package:get/get.dart';
    class AppInitializer {
      static Future<void> initialize() async {
        // init external services
        // e.g await Firebase.initializeApp();
      }
    }
    ''';

    // create file
    File file = File('$path/app_initializer.dart');

    // write to file
    file.writeAsStringSync(content);
  }

  // app theme
  Future<void> appThemeGen(String path) async {
    String content = '''
    import 'package:flutter/material.dart';
    class AppTheme {
      ThemeData lightThemeData() {
        return ThemeData(
          colorScheme: const ColorScheme.light(),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        );
      }

      ThemeData darkThemeData() {
        return ThemeData(
          colorScheme: const ColorScheme.dark(),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        );
      }
    }
    ''';

    // create file
    File file = File('$path/app_theme.dart');

    // write to file
    file.writeAsStringSync(content);
  }
}
