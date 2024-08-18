import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  // sizes
  static const double rail = 70.0;
  static const double sidebar = 200.0;

  // supabase
  static String supabaseCallback = 'com.supabase.auth://auth-callback/';
  static String supabaseURL = dotenv.env['SUBAPASE_URL'] ?? '';
  static String supabaseAnonKey = dotenv.env['SUBAPASE_ANON_KEY'] ?? '';

  // sentry
  static String sentryDNS = dotenv.env['SENTRY_DNS'] ?? '';
}
