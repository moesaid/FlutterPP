import 'package:flutterpp/App/Services/Auth/auth_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:flutterpp/App/Views/Global/build_snackbar.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VerifyOtpController extends GetxController {
  String email = Get.arguments['email'] ?? '';
  OtpType otpType = Get.arguments['otpType'] ?? OtpType.magiclink;

  final AuthServices _authServices = AuthServices();

  final _needToResendOtp = true.obs;
  bool get needToResendOtp => _needToResendOtp.value;

  final _sentCount = 0.obs;
  int get sentCount => _sentCount.value;

  @override
  Future<void> onInit() async {
    await _updateSentStatus();
    super.onInit();
  }

  Future<void> verifyOtp(Map<String, dynamic> value) async {
    try {
      AuthResponse? res = await Get.showOverlay(
        asyncFunction: () async {
          return await _authServices.verifyOtp(
            type: otpType,
            otp: value['otp'],
            email: email,
          );
        },
        loadingWidget: const BuildOverlay(),
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
        Get.offAllNamed(AppRoutes.SPLASH);
        return;
      }
    } on AuthException catch (e) {
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
    bool isSent = await Get.showOverlay(
      asyncFunction: () async {
        return await _authServices.signInWithOtp(email: email);
      },
      loadingWidget: const BuildOverlay(),
    );

    if (isSent) {
      BuildSnackBar(
        title: 'Success',
        message: 'OTP sent successfully, please check your email',
      ).success();
      await _updateSentStatus();
    }
  }

  Future<void> _updateSentStatus() async {
    _needToResendOtp.value = false;

    update();

    // count 60 seconds and update the value
    for (var i = 0; i < 60; i++) {
      await Future.delayed(const Duration(seconds: 1));
      _sentCount.value = i;
      update();
    }

    _needToResendOtp.value = true;
    _sentCount.value = 0;
    update();
  }
}
