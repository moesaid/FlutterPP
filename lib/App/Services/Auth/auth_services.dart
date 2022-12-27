import 'package:appwrite/appwrite.dart';
import 'package:flutterpp/App/Providers/Network/auth_provider.dart';
import 'package:flutterpp/App/Providers/call_pipeline.dart';

class AuthServices {
  final AuthProvider _authProvider = AuthProvider();
  final CallPipeline _callPipeline = CallPipeline();

  // register
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    // Create Account
    Account? acc = await _callPipeline.futurePipeline(
      future: () => _authProvider.createAccount(
        name: name,
        email: email,
        password: password,
      ),
      name: 'register',
    );

    if (acc == null) return;
  }

  // login
  Future<void> login({
    required String email,
    required String password,
  }) async {
    // Login
    Account? acc = await _callPipeline.futurePipeline(
      future: () => _authProvider.login(
        email: email,
        password: password,
      ),
      name: 'login',
    );

    if (acc == null) return;
  }

  // create verification email
  Future<void> createVerificationEmail({
    required String url,
  }) async {
    // Create Verification Email
    var res = await _callPipeline.futurePipeline(
      future: () => _authProvider.createVerificationEmail(
        url: url,
      ),
      name: 'createVerificationEmail',
    );

    if (res == null) return;
  }

  // verify email
  Future<void> verifyEmail({
    required String userId,
    required String secret,
  }) async {
    // Verify Email
    var res = await _callPipeline.futurePipeline(
      future: () => _authProvider.verifyEmail(
        userId: userId,
        secret: secret,
      ),
      name: 'verifyEmail',
    );

    if (res == null) return;
  }
}
