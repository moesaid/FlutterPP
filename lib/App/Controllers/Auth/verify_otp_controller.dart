import 'package:flutter/material.dart';
import 'package:flutterpp/App/Services/Auth/auth_services.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VerifyOtpController extends GetxController {
  String email = Get.parameters['email'] ?? '';

  final AuthServices _authServices = AuthServices();

  final _needToResendOtp = false.obs;
  bool get needToResendOtp => _needToResendOtp.value;

  Future<void> verifyOtp(Map<String, dynamic> value) async {
    print({value['otp'], email});
    try {
      AuthResponse? res = await _authServices.verifyOtp(
        otp: value['otp'],
        email: email,
      );

      if (res == null) {
        Get.snackbar(
          'Error',
          'Something went wrong',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (res.session != null) {
        Get.offAllNamed(AppRoutes.HOME);
      }
    } on AuthException catch (e) {
      if (e.statusCode == '401') {
        _needToResendOtp.value = true;
        update();
      }

      Get.snackbar(
        'Error',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(20),
      );
    } catch (e) {
      print('error: $e');
    }
  }

  // Resend OTP
  Future<void> resendOtp() async {
    bool isSent = await _authServices.signInWithOtp(email: email);
    if (isSent) {
      Get.snackbar(
        'Success',
        'OTP sent',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(20),
      );
    }
  }
}
