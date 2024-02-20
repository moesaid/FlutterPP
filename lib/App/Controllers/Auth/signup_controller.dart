import 'package:flutterpp/App/Services/Auth/auth_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:flutterpp/App/Views/Global/build_snackbar.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupController extends GetxController {
  // signup
  Future<void> signup(Map<String, dynamic> value) async {
    AuthResponse? res = await Get.showOverlay(
      asyncFunction: () async {
        return await AuthServices().signUp(
          name: value['name'],
          email: value['email'],
          password: value['password'],
        );
      },
      loadingWidget: const BuildOverlay(),
    );

    if (res == null || res.user?.id == null) {
      BuildSnackBar(
        title: 'Error',
        message: 'Something went wrong while signing up , please try again',
      ).error();

      return;
    }

    Get.toNamed(AppRoutes.VERIFY_OTP, arguments: {
      'email': value['email'],
      'otpType': OtpType.signup,
    });
  }
}
