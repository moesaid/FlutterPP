import 'package:flutterpp/App/Services/Auth/auth_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  final supabase = Supabase.instance.client;

  Future<void> login(Map<String, dynamic> value) async {
    bool? isSend = await Get.showOverlay(
      asyncFunction: () async {
        return await AuthServices().signInWithOtp(email: value['email']);
      },
      loadingWidget: const BuildOverlay(),
    );

    if (isSend == true) {
      Get.toNamed(AppRoutes.VERIFY_OTP, arguments: {
        'email': value['email'],
        'otpType': OtpType.magiclink,
      });
    }
  }
}
