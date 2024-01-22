import 'package:flutterpp/App/Services/Global/call_pipeline.dart';
import 'package:flutterpp/Config/app_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider {
  CallPipeline callPipeline = CallPipeline();
  final supabase = Supabase.instance.client;

  // signInWithOtp
  Future<void> signInWithOtp({required String email}) async {
    callPipeline.futurePipeline(
      future: () async {
        await supabase.auth.signInWithOtp(
          email: email,
          emailRedirectTo: AppConfig().supabaseCallback,
        );
      },
      name: 'sign in with otp',
    );
  }

  // verifyOtp
  Future<AuthResponse?> verifyOtp({
    OtpType? type,
    required String otp,
    required String email,
  }) async {
    return callPipeline.futurePipeline(
      future: () async {
        return await supabase.auth.verifyOTP(
          token: otp,
          email: email,
          type: type ?? OtpType.magiclink,
        );
      },
      name: 'verify otp',
    );
  }

  // sign up
  Future<AuthResponse?> signUp({
    required String email,
    required String name,
    required String password,
  }) async {
    return callPipeline.futurePipeline(
      future: () async {
        return await supabase.auth.signUp(
          data: {'full_name': name},
          email: email,
          password: password,
          emailRedirectTo: AppConfig().supabaseCallback,
        );
      },
      name: 'sign up',
    );
  }

  // sign in
  Future<AuthResponse?> signIn({
    required String email,
    required String password,
  }) async {
    return callPipeline.futurePipeline(
      future: () async {
        return await supabase.auth.signInWithPassword(
          email: email,
          password: password,
        );
      },
      name: 'sign in',
    );
  }

  // sign out
  Future<void> signOut() async {
    callPipeline.futurePipeline(
      future: () async {
        await supabase.auth.signOut();
      },
      name: 'sign out',
    );
  }

  User? currentUser() {
    return supabase.auth.currentUser!;
  }
}
