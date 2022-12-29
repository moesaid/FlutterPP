import 'package:flutterpp/Config/app_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider {
  final supabase = Supabase.instance.client;

  // signInWithOtp
  Future<void> signInWithOtp({required String email}) async {
    await supabase.auth.signInWithOtp(
      email: email,
      emailRedirectTo: AppConfig().supabaseCallback,
    );
  }

  // verifyOtp
  Future<AuthResponse> verifyOtp({
    OtpType? type,
    required String otp,
    required String email,
  }) async {
    AuthResponse res = await supabase.auth.verifyOTP(
      token: otp,
      email: email,
      type: type ?? OtpType.magiclink,
    );

    return res;
  }

  // sign up
  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    AuthResponse res = await supabase.auth.signUp(
      email: email,
      password: password,
      emailRedirectTo: AppConfig().supabaseCallback,
    );

    return res;
  }

  // sign in
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    AuthResponse res = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    return res;
  }

  // sign out
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}
