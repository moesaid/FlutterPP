// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class AppRoutes {
  // auth
  static const SPLASH = '/';
  static const SIGNUP = '/signup';
  static const LOGIN = '/login';
  static const VERIFY_OTP = '/verify-otp';

  // home
  static const HOME = '/home';

  // teams
  static const No_TEAM = '/no-team';

  // mockup
  static const MOCKUP_INDEX = '/mockup-index';
  static const MOCKUP_CREATE = '/mockup-create';
  static const MOCKUP_SINGLE = '/mockup-single';

  // project
  static const PROJECT_SINGLE = '/project-single';

  // invoice
  static const INVOICE_SINGLE = '/invoice-single';
}
