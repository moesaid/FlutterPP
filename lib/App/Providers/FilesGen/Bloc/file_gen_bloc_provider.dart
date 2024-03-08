import 'dart:io';

import 'package:flutterpp/Helpers/text_helper.dart';

class FileGenBlocProvider {
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
    import 'package:$nameSpace/App/Blocs/${(custom?.toPascalCase() ?? name.toPascalCase())}/${name.toSnakeCase()}_Bloc.dart';



    }
    ''';

    // create file
    File file = File('$path/${name.toSnakeCase()}_page.dart');

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
      final router = GoRouter(initialLocation: AppRoutes.SPLASH, routes: [
        GoRoute(
          path: AppRoutes.HOME,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppRoutes.COUNTER,
          builder: (context, state) => const CounterPage(),
        ),
      ]);
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
