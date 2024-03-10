import 'dart:io';

import 'package:flutterpp/Helpers/text_helper.dart';

class FileGenBlocProvider {
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
    import 'package:$nameSpace/Config/Exernal/app_initializer.dart';
    import 'package:$nameSpace/Config/Theme/app_theme.dart';
    import 'package:$nameSpace/App/Blocs/Theme/theme_bloc.dart';
    import 'package:$nameSpace/App/Blocs/Theme/theme_event.dart';
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
        return BlocProvider(
          create: (context) => ThemeBloc()..add(InitialThemeSetEvent()),
          child: BlocBuilder<ThemeBloc, ThemeData>(
            builder: (context, state) {
              return MaterialApp.router(
                title: 'Google',
                debugShowCheckedModeBanner: false,
                routerConfig: AppPages.router,
                theme: state,
              );
            },
          ),
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

  // create bloc
  Future<void> blocGen(String name, String path) async {
    /// event class
    String eventContent = '''
      import 'package:flutter_bloc/flutter_bloc.dart';

      part of '${name.toSnakeCase()}_bloc.dart';

      sealed class ${name.toPascalCase()}Event {}
    ''';

    /// state class
    String stateContent = '''
      import 'package:flutter_bloc/flutter_bloc.dart';

      part of '${name.toSnakeCase()}_bloc.dart';

      sealed class ${name.toPascalCase()}State {}

      final class ${name.toPascalCase()}Initial extends ${name.toPascalCase()}State {}
      ''';

    /// bloc class
    String blocContent = '''
      import 'package:flutter_bloc/flutter_bloc.dart';

      part '${name.toSnakeCase()}_event.dart';
      part '${name.toSnakeCase()}_state.dart';

      class ${name.toPascalCase()}Bloc extends Bloc<${name.toPascalCase()}Event, ${name.toPascalCase()}State> {
        ${name.toPascalCase()}Bloc() : super(${name.toPascalCase()}Initial()) {
          on<${name.toPascalCase()}Event>((event, emit) {
            // TODO: implement event handler
          });
        }
      }
    ''';

    /// write files
    File eventFile = File('$path/${name.toSnakeCase()}_event.dart');
    File stateFile = File('$path/${name.toSnakeCase()}_state.dart');
    File blocFile = File('$path/${name.toSnakeCase()}_bloc.dart');
    eventFile.writeAsStringSync(eventContent);
    stateFile.writeAsStringSync(stateContent);
    blocFile.writeAsStringSync(blocContent);
  }

  // create cubit
  Future<void> cubitGen(String name, String path) async {
    /// state class
    String stateContent = '''
      part of '${name.toSnakeCase()}_cubit.dart';

      sealed class ${name.toPascalCase()}State {}

      final class ${name.toPascalCase()}Initial extends ${name.toPascalCase()}State {}
      ''';

    /// cubit class
    String cubitContent = '''
      import 'package:flutter_bloc/flutter_bloc.dart';

      part '${name.toSnakeCase()}_state.dart';

      class ${name.toPascalCase()}Cubit extends Cubit<${name.toPascalCase()}State> {
        ${name.toPascalCase()}Cubit() : super(${name.toPascalCase()}Initial());
      }
    ''';

    /// write files
    File stateFile = File('$path/${name.toSnakeCase()}_state.dart');
    File cubitFile = File('$path/${name.toSnakeCase()}_cubit.dart');

    stateFile.writeAsStringSync(stateContent);
    cubitFile.writeAsStringSync(cubitContent);
  }

  // create page
  Future<void> pageGen(
    String nameSpace,
    String name,
    String path, {
    String? custom,
    bool? isBloc,
    bool? isCubit,
  }) async {
    String content = '''
    import 'package:flutter/material.dart';
    import 'package:flutter_bloc/flutter_bloc.dart';

    ${isBloc == true ? "import 'package:$nameSpace/App/Blocs/${(custom?.toPascalCase() ?? name.toPascalCase())}/${name.toSnakeCase()}_bloc.dart';" : ""}
    ${isCubit == true ? "import 'package:$nameSpace/App/Cubits/${(custom?.toPascalCase() ?? name.toPascalCase())}/${name.toSnakeCase()}_cubit.dart';" : ""}


    class ${name.toPascalCase()}Page extends StatelessWidget {
      const ${name.toPascalCase()}Page({super.key});

      @override
      Widget build(BuildContext context) {
        ${isBloc == true ? "return BlocBuilder<${name.toPascalCase()}Bloc, ${name.toPascalCase()}BlocState>(" : ""}
        ${isCubit == true ? "return BlocBuilder<${name.toPascalCase()}Cubit, ${name.toPascalCase()}CubitState>(" : ""}

          create: (_) => ${isBloc == true ? "${name.toPascalCase()}Bloc()" : "${name.toPascalCase()}Cubit()"},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(title: const Text('${name.toPascalCase()} Page')),
              body: const SafeArea(child: Text('${name.toPascalCase()} Page')),
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

  // create app pages
  Future<void> appPagesGen(String nameSpace, String path) async {
    String content = '''
    import 'package:go_router/go_router.dart';
    import 'package:$nameSpace/App/Views/Pages/Auth/splash_page.dart';
    import 'package:$nameSpace/App/Views/Pages/Counter/counter_page.dart';
    import 'package:$nameSpace/App/Views/Pages/Home/home_page.dart';

    part 'app_routes.dart';

    class AppPages {
      static final router = GoRouter(
        initialLocation: AppRoutes.SPLASH,
        routes: [
          GoRoute(
            path: AppRoutes.SPLASH,
            builder: (context, state) => const SplashPage(),
          ),
          GoRoute(
            path: AppRoutes.HOME,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: AppRoutes.COUNTER,
            builder: (context, state) => const CounterPage(),
          ),
        ],
      );
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
    import 'package:get_storage/get_storage.dart';
    class AppInitializer {
      static Future<void> initialize() async {
        await GetStorage.init();

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
