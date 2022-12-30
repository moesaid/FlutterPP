import 'package:flutterpp/App/Services/Auth/auth_services.dart';
import 'package:flutterpp/App/Views/Global/build_snackbar.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VerifyOtpController extends GetxController {
  String email = Get.arguments['email'] ?? '';
  OtpType otpType = Get.arguments['otpType'] ?? OtpType.magiclink;

  final AuthServices _authServices = AuthServices();

  final _needToResendOtp = false.obs;
  bool get needToResendOtp => _needToResendOtp.value;

  Future<void> verifyOtp(Map<String, dynamic> value) async {
    try {
      AuthResponse? res = await _authServices.verifyOtp(
        type: otpType,
        otp: value['otp'],
        email: email,
      );

      if (res == null) {
        BuildSnackBar(
          title: 'Error',
          message:
              'Something went wrong while verifying OTP , please try again',
        ).error();
        return;
      }

      if (res.session != null) {
        Get.offAllNamed(AppRoutes.HOME);
        return;
      }
    } on AuthException catch (e) {
      if (e.statusCode == '401') {
        _needToResendOtp.value = true;
        update();
      }

      BuildSnackBar(
        title: 'Error',
        message: e.message,
      ).error();

      return;
    } catch (e) {
      BuildSnackBar(
        title: 'Error',
        message: e.toString(),
      ).error();

      return;
    }
  }

  // Resend OTP
  Future<void> resendOtp() async {
    bool isSent = await _authServices.signInWithOtp(email: email);
    if (isSent) {
      BuildSnackBar(
        title: 'Success',
        message: 'OTP sent successfully, please check your email',
      ).success();
    }
  }
}
