import 'package:flutterpp/App/Views/Pages/Auth/login_page.dart';
import 'package:flutterpp/App/Views/Pages/Auth/signup_page.dart';
import 'package:flutterpp/App/Views/Pages/Auth/splash_page.dart';
import 'package:flutterpp/App/Views/Pages/Auth/verify_otp_page.dart';
import 'package:flutterpp/App/Views/Pages/Home/home_page.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/mockup_create_page.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/mockup_index_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.SPLASH, page: () => const SplashPage()),
    GetPage(name: AppRoutes.SIGNUP, page: () => const SignupPage()),
    GetPage(name: AppRoutes.LOGIN, page: () => const LoginPage()),
    GetPage(name: AppRoutes.VERIFY_OTP, page: () => const VerifyOtpPage()),
    GetPage(name: AppRoutes.HOME, page: () => const HomePage()),
    GetPage(name: AppRoutes.MOCKUP_INDEX, page: () => const MockupIndexPage()),
    GetPage(
      name: AppRoutes.MOCKUP_CREATE,
      page: () => const MockupCreatePage(),
    ),
  ];
}
