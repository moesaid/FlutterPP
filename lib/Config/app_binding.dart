import 'package:flutterpp/App/Controllers/Auth/login_controller.dart';
import 'package:flutterpp/App/Controllers/Auth/signup_controller.dart';
import 'package:flutterpp/App/Controllers/Auth/splash_controller.dart';
import 'package:flutterpp/App/Controllers/Auth/verify_otp_controller.dart';
import 'package:flutterpp/App/Controllers/Home/home_controller.dart';
import 'package:flutterpp/App/Controllers/dashboard_controller.dart';
import 'package:get/get.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    // Auth
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<SignupController>(() => SignupController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<VerifyOtpController>(() => VerifyOtpController());

    // Home
    Get.lazyPut<HomeController>(() => HomeController());

    // Dashboard
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
