import 'package:flutterpp/App/Services/Auth/auth_services.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  final supabase = Supabase.instance.client;

  Future<void> login(Map<String, dynamic> value) async {
    bool isSend = await AuthServices().signInWithOtp(email: value['email']);

    if (isSend) {
      Get.toNamed(AppRoutes.VERIFY_OTP, arguments: {
        'email': value['email'],
        'otpType': OtpType.magiclink,
      });
    }
  }
}
