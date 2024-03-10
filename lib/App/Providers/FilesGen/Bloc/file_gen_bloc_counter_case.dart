import 'dart:io';

import 'package:flutterpp/Helpers/text_helper.dart';

class FileGenBlocCounterCase {
  // create splash cubit
  Future<void> splashCubitGen(
    String nameSpace,
    String name,
    String path,
  ) async {
    String content = '''
      import 'dart:async';

      import 'package:flutter/material.dart';
      import 'package:flutter_bloc/flutter_bloc.dart';
      import 'package:go_router/go_router.dart';
      import 'package:$nameSpace/Routes/app_pages.dart';

      class SplashCubit extends Cubit<int> {
        SplashCubit() : super(0);

        // init
        void intCount(BuildContext context) {
          Timer.periodic(const Duration(milliseconds: 50), (timer) {
            // increment the count
            emit(state + 1);

            // if the count is less than 10
            if (timer.tick == 100) {
              // cancel the timer
              timer.cancel();

              // remove all the previous routes and navigate to the home page
              context.go(AppRoutes.HOME);
            }
          });
        }
      }

    ''';

    // create file
    File file = File('$path/${name.toSnakeCase()}_cubit.dart');

    // write to file
    file.writeAsStringSync(content);
  }

  // create home cubit
  Future<void> homeCubitGen(String name, String path) async {
    String cubitContent = '''
      import 'package:flutter_bloc/flutter_bloc.dart';

      part 'home_state.dart';

      class HomeCubit extends Cubit<HomeState> {
        HomeCubit() : super(HomeStateInitial());
      }
    ''';

    String stateContent = '''
      part of 'home_cubit.dart';

      abstract class HomeState {}

      class HomeStateInitial extends HomeState {}
    ''';

    // write to file
    File fileCubit = File('$path/${name.toSnakeCase()}_cubit.dart');
    File fileState = File('$path/${name.toSnakeCase()}_state.dart');
    fileCubit.writeAsStringSync(cubitContent);
    fileState.writeAsStringSync(stateContent);
  }

  // create counter cubit
  Future<void> counterCubitGen(String name, String path) async {
    String content = '''
      import 'package:get/get.dart';

      class ${name.toPascalCase()}Controller extends GetxController {
          final _count = 0.obs;
          int get count => _count.value;

          // increase count
          void increaseCount() {
            _count.value++;
            update();
          }

          // decrease count
          void decreaseCount() {
            if (_count.value > 0) _count.value--;
            update();
          }

          // reset count
          void resetCount() {
            _count.value = 0;
            update();
          }
      }
    ''';

    // create file
    File file = File('$path/${name.toSnakeCase()}_controller.dart');

    // write to file
    file.writeAsStringSync(content);
  }

  // create splash page
  Future<void> pageGenSplash(
    String nameSpace,
    String name,
    String path, {
    String? custom,
  }) async {
    String content = '''
    import 'package:flutter/material.dart';
    import 'package:get/get.dart';
    import 'package:$nameSpace/App/Cubits/${(custom?.toPascalCase() ?? name.toPascalCase())}/${name.toSnakeCase()}_cubit.dart';

      class SplashPage extends StatelessWidget {
        const SplashPage({super.key});

        @override
        Widget build(BuildContext context) {
          return BlocBuilder<SplashCubit, int>(
            bloc: SplashCubit()..intCount(context),
            builder: (context, state) {
              return Scaffold(
                body: SafeArea(
                  child: SizedBox.expand(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        const FlutterLogo(size: 100),
                        const SizedBox(height: 20),
                        const Text(
                          'Splash Page',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$state %',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      }
    }
    ''';

    // create file
    File file = File('$path/${name.toSnakeCase()}_page.dart');

    // write to file
    file.writeAsStringSync(content);
  }

  // home page
  Future<void> pageGenHome(
    String nameSpace,
    String name,
    String path, {
    String? custom,
  }) async {
    String content = '''
    import 'package:flutter/material.dart';

    import 'package:flutter/material.dart';
    import 'package:flutter_bloc/flutter_bloc.dart';
    import 'package:go_router/go_router.dart';
    import 'package:$nameSpace/App/Blocs/Theme/theme_bloc.dart';
    import 'package:$nameSpace/App/Blocs/Theme/theme_event.dart';
    import 'package:$nameSpace/App/Cubits/Home/home_cubit.dart';
    import 'package:$nameSpace/Routes/app_pages.dart';

    class HomePage extends StatelessWidget {
      const HomePage({super.key});

      @override
      Widget build(BuildContext context) {
        return BlocProvider(
          create: (_) => HomeCubit(),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(title: const Text('HomePage')),
                body: SafeArea(
                  child: SizedBox.expand(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FlutterLogo(size: 80),
                        const SizedBox(height: 20),
                        const Text(
                          'Home Page',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        FilledButton(
                          onPressed: () {
                            BlocProvider.of<ThemeBloc>(context)
                                .add(ThemeSwitchEvent());
                          },
                          child: const Text('Toggle Theme Mode'),
                        ),
                        const Divider(height: 40, thickness: 0.1),
                        const Text(
                          'navigate to',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        FilledButton(
                          onPressed: () {
                            context.push(AppRoutes.COUNTER);
                          },
                          child: const Text('Counter Page'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }
    }

    ''';

    // create file
    File file = File('$path/${name.toSnakeCase()}_page.dart');

    // write to file
    file.writeAsStringSync(content);
  }

  // counter page
  Future<void> pageGenCounter(
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
              appBar: AppBar(title: const Text('Counter Page')),
              body: SafeArea(
                child: SizedBox.expand(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        clipBehavior: Clip.none,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: context.width * 0.25,
                            height: context.width * 0.25,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.grey.withOpacity(0.2),
                              ),
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(
                                controller.count / 100,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20,
                                  spreadRadius: -6,
                                  color: Colors.black.withOpacity(
                                    controller.count / 100,
                                  ),
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Center(
                              child: AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 300),
                                style: TextStyle(
                                  fontSize: context.width * 0.07,
                                  fontWeight: FontWeight.bold,
                                  color: controller.count.isLowerThan(20)
                                      ? Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black
                                      : Colors.white,
                                ),
                                child: Text('\${controller.count}'),
                              ),
                            ),
                          ),
                          Positioned(
                            right: -context.width * 0.02,
                            top: -context.width * 0.02,
                            child: IconButton.filled(
                              onPressed: () => controller.resetCount(),
                              icon: const Icon(Icons.refresh),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton(
                            onPressed: () => controller.increaseCount(),
                            child: const Text('Increase'),
                          ),
                          const SizedBox(width: 20),
                          FilledButton(
                            onPressed: () => controller.decreaseCount(),
                            child: const Text('Decrease'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
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

  // create theme bloc
  Future<void> themeBlocGen(String nameSpace, String path) async {
    String blocContent = '''
      import 'package:flutter/material.dart';
      import 'package:flutter_bloc/flutter_bloc.dart';
      import 'package:$nameSpace/App/Blocs/Theme/theme_event.dart';
      import 'package:$nameSpace/Storage/theme_storage.dart';

      class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
        ThemeBloc() : super(ThemeData.light()) {
          //when app is started
          on<InitialThemeSetEvent>((event, emit) async {
            final bool hasDarkTheme = isDark();
            if (hasDarkTheme) {
              emit(ThemeData.dark());
            } else {
              emit(ThemeData.light());
            }
          });

          //while switch is clicked
          on<ThemeSwitchEvent>((event, emit) {
            final hasDarkTheme = isDark();
            setTheme(!hasDarkTheme);

            final newIsDark = isDark();

            emit(newIsDark ? ThemeData.dark() : ThemeData.light());
          });
        }

        // setTheme
        Future<void> setTheme(bool isDark) async {
          final ThemeStorage themeStorage = ThemeStorage();
          await themeStorage.write(isDark);
        }

        bool isDark() {
          final ThemeStorage themeStorage = ThemeStorage();
          final bool isDark = themeStorage.read();

          return isDark;
        }
      }

    ''';

    String eventContent = '''
      import 'package:flutter/foundation.dart';

      @immutable
      abstract class ThemeEvent {}

      class InitialThemeSetEvent extends ThemeEvent {}

      class ThemeSwitchEvent extends ThemeEvent {}
    ''';

    // create file
    File blocFile = File('$path/theme_bloc.dart');
    File eventFile = File('$path/theme_event.dart');

    blocFile.writeAsStringSync(blocContent);
    eventFile.writeAsStringSync(eventContent);
  }

  // create theme storage
  Future<void> themeStorageGen(String nameSpace, String path) async {
    String content = '''
      import 'package:get_storage/get_storage.dart';

      class ThemeStorage {
        final box = GetStorage();

        final String key = 'isDarkMode';

        // read
        bool read() {
          // read from storage
          final String? theme = box.read(key);

          // if null return false
          if (theme == null) {
            return false;
          }

          // if not null value is string
          // convert to bool
          return theme == 'true';
        }

        // write
        Future<bool> write(bool isDark) async {
          // write to storage
          await box.write(key, isDark.toString());

          return read();
        }

        // remove
        remove() async {
          // remove from storage
          await box.remove(key);
        }
      }

    ''';

    // create file
    File file = File('$path/theme_storage.dart');

    // write to file
    file.writeAsStringSync(content);
  }
}
