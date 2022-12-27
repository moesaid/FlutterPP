import 'package:flutterpp/App/Providers/Local/user_token.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  Future<void> onReady() async {
    await _nextPage();
    super.onReady();
  }

  _nextPage() async {
    String token = await UserToken().read();
    bool isAuth = token.isNotEmpty;

    Future.delayed(const Duration(seconds: 2), () {
      if (isAuth) {
        Get.offNamed(AppRoutes.HOME);
      } else {
        Get.offNamed(AppRoutes.REGISTER);
      }
    });
  }
}
