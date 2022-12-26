import 'package:flutterpp/App/Views/Pages/Auth/login_page.dart';
import 'package:flutterpp/App/Views/Pages/Auth/splash_page.dart';
import 'package:flutterpp/App/Views/Pages/Home/home_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.SPLASH, page: () => const SplashPage()),
    GetPage(name: AppRoutes.LOGIN, page: () => const LoginPage()),
    GetPage(name: AppRoutes.HOME, page: () => const HomePage()),
  ];
}
