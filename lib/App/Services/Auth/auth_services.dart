import 'package:flutterpp/App/Providers/Network/Auth/auth_provider.dart';
import 'package:flutterpp/App/Services/Global/call_pipeline.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {
  final AuthProvider _authProvider = AuthProvider();
  final CallPipeline _callPipeline = CallPipeline();

  // signInWithOtp
  Future<bool?> signInWithOtp({required String email}) async {
    return _authProvider.signInWithOtp(email: email);
  }

  // verifyOtp
  Future<AuthResponse?> verifyOtp({
    OtpType? type,
    required String otp,
    required String email,
  }) async {
    return await _callPipeline.futurePipeline(
      future: () => _authProvider.verifyOtp(
        otp: otp,
        type: type,
        email: email,
      ),
      name: 'verifyOtp',
    );
  }

  // signUp
  Future<AuthResponse?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    AuthResponse? res = await _callPipeline.futurePipeline(
      future: () => _authProvider.signUp(
        name: name,
        email: email,
        password: password,
      ),
      name: 'signUp',
    );

    return res;
  }

  // signIn
  Future signIn({
    required String email,
    required String password,
  }) async {
    await _callPipeline.futurePipeline(
      future: () => _authProvider.signIn(email: email, password: password),
      name: 'signIn',
    );
  }

  // signOut
  Future<void> signOut() async {
    await Get.showOverlay(
      asyncFunction: () async {
        await _callPipeline.futurePipeline(
          future: () => _authProvider.signOut(),
          name: 'signOut',
        );
        await GetStorage().erase();
      },
      loadingWidget: const BuildOverlay(),
    );

    Get.offAllNamed(AppRoutes.SPLASH);
  }

  // current user
  User? currentUser() {
    return _authProvider.currentUser();
  }
}
