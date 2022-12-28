import 'package:flutterpp/App/Providers/Network/auth_provider.dart';
import 'package:flutterpp/App/Services/call_pipeline.dart';

class AuthServices {
  final AuthProvider _authProvider = AuthProvider();
  final CallPipeline _callPipeline = CallPipeline();

  // signInWithOtp
  Future<void> signInWithOtp({required String email}) async {
    await _callPipeline.futurePipeline(
      future: () => _authProvider.signInWithOtp(email: email),
      name: 'signInWithOtp',
    );
  }
}
