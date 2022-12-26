import 'package:flutterpp/App/Controllers/Auth/login_controller.dart';
import 'package:flutterpp/App/Controllers/Auth/splash_controller.dart';
import 'package:flutterpp/App/Controllers/Home/home_controller.dart';
import 'package:get/get.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    // Auth
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<LoginController>(() => LoginController());

    // Home
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
