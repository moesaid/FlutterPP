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
}
