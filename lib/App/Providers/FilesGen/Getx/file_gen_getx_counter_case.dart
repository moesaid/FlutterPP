import 'dart:io';

import 'package:flutterpp/Helpers/text_helper.dart';

class FileGenGetxCounterCase {
  // create splash controller
  Future<void> splashControllerGen(
    String nameSpace,
    String name,
    String path,
  ) async {
    String content = '''
      import 'dart:async';

      import 'package:get/get.dart';
      import 'package:$nameSpace/Routes/app_pages.dart';
      class ${name.toPascalCase()}Controller extends GetxController {
        final _count = 0.obs;
        int get count => _count.value;

        @override
        void onInit() {
          _intCount();
          super.onInit();
        }

        void _intCount() {
          Timer.periodic(const Duration(milliseconds: 50), (timer) {
            _count.value++;

            // if the count is less than 10
            if (timer.tick.isEqual(100)) {
              // cancel the timer
              timer.cancel();

              // remove all the previous routes and navigate to the home page
              Get.offAllNamed(AppRoutes.HOME);
            }
          });
        }
      }
    ''';

    // create file
    File file = File('$path/${name.toSnakeCase()}_controller.dart');

    // write to file
    file.writeAsStringSync(content);
  }

  // create home controller
  Future<void> homeControllerGen(String name, String path) async {
    String content = '''
      import 'package:flutter/material.dart';
      import 'package:get/get.dart';

      class ${name.toPascalCase()}Controller extends GetxController {
        // toggle theme mode
        void toggleThemeMode() {
          Get.changeThemeMode(
            Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
          );
        }
      }
    ''';

    // create file
    File file = File('$path/${name.toSnakeCase()}_controller.dart');

    // write to file
    file.writeAsStringSync(content);
  }

  // create counter controller
  Future<void> counterControllerGen(String name, String path) async {
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
                      Obx(
                        () => Text(
                          '\${controller.count}%',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
              appBar: AppBar(title: const Text('Home Page')),
              body: SafeArea(
                child: SizedBox.expand(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FlutterLogo(size: 80),
                      const SizedBox(height: 20),
                      Text(
                        'Home Page'.capitalize!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FilledButton(
                        onPressed: () => controller.toggleThemeMode(),
                        child: const Text('Toggle Theme Mode'),
                      ),
                      const Divider(height: 40, thickness: 0.1),
                      Text(
                        'navigate to'.capitalize!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FilledButton(
                        onPressed: () {
                          Get.toNamed('/counter');
                        },
                        child: const Text('Counter Page'),
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
}
