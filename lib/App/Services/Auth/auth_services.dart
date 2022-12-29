import 'package:flutterpp/App/Providers/Network/auth_provider.dart';
import 'package:flutterpp/App/Services/call_pipeline.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {
  final AuthProvider _authProvider = AuthProvider();
  final CallPipeline _callPipeline = CallPipeline();

  // signInWithOtp
  Future<bool> signInWithOtp({required String email}) async {
    try {
      await _callPipeline.futurePipeline(
        future: () => _authProvider.signInWithOtp(email: email),
        name: 'signInWithOtp',
      );
      return true;
    } catch (e) {
      return false;
    }
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
  Future signUp({
    required String email,
    required String password,
  }) async {
    AuthResponse? res = await _callPipeline.futurePipeline(
      future: () => _authProvider.signUp(email: email, password: password),
      name: 'signUp',
    );

    print({
      'res': res,
      'session accessToken': res?.session?.accessToken,
      'session user id': res?.session?.user.id,
      'user id': res?.user?.id,
    });
  }

  // signIn
  Future signIn({
    required String email,
    required String password,
  }) async {
    AuthResponse? res = await _callPipeline.futurePipeline(
      future: () => _authProvider.signIn(email: email, password: password),
      name: 'signIn',
    );
  }

  // signOut
  Future<void> signOut() async {
    await _callPipeline.futurePipeline(
      future: () => _authProvider.signOut(),
      name: 'signOut',
    );
  }
}
