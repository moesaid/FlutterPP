import 'package:flutterpp/Routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashController extends GetxController {
  final supabase = Supabase.instance.client;

  @override
  Future<void> onReady() async {
    await _nextPage();
    super.onReady();
  }

  _nextPage() async {
    final Session? session = supabase.auth.currentSession;

    Future.delayed(const Duration(seconds: 2), () {
      if (session != null) {
        Get.offNamed(AppRoutes.HOME);
      } else {
        Get.offNamed(AppRoutes.SIGNUP);
      }
    });
  }
}
