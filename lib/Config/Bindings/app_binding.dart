import 'package:flutterpp/App/Controllers/Auth/login_controller.dart';
import 'package:flutterpp/App/Controllers/Auth/signup_controller.dart';
import 'package:flutterpp/App/Controllers/Auth/splash_controller.dart';
import 'package:flutterpp/App/Controllers/Auth/verify_otp_controller.dart';
import 'package:flutterpp/App/Controllers/Home/home_controller.dart';
import 'package:flutterpp/App/Controllers/Mockup/Micro/alignment_option_controller.dart';
import 'package:flutterpp/App/Controllers/Mockup/Micro/bool_toggle_controller.dart';
import 'package:flutterpp/App/Controllers/Mockup/build_create_mockup_sidebar_selected_state_controller.dart';
import 'package:flutterpp/App/Controllers/Mockup/change_fontfamily_controller.dart';
import 'package:flutterpp/App/Controllers/Mockup/mockup_create_controller.dart';
import 'package:flutterpp/App/Controllers/Mockup/mockup_index_controller.dart';
import 'package:flutterpp/App/Controllers/Mockup/mockup_single_controller.dart';
import 'package:flutterpp/App/Controllers/Project/project_index_controller.dart';
import 'package:flutterpp/App/Controllers/Project/project_single_controller.dart';
import 'package:flutterpp/App/Controllers/Team/no_team_controller.dart';
import 'package:flutterpp/App/Controllers/dashboard_controller.dart';
import 'package:get/get.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    // Auth
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<SignupController>(() => SignupController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<VerifyOtpController>(() => VerifyOtpController());

    // Home
    Get.lazyPut<HomeController>(() => HomeController());

    // Dashboard
    Get.lazyPut<DashboardController>(() => DashboardController());

    // team
    Get.lazyPut<NoTeamController>(() => NoTeamController());

    // project
    Get.lazyPut<ProjectIndexController>(() => ProjectIndexController());
    Get.lazyPut<ProjectSingleController>(() => ProjectSingleController());
    // Get.lazyPut<ProjectSingleWikiController>(
    //   () => ProjectSingleWikiController(),
    // );

    // mockup
    Get.lazyPut<MockupIndexController>(() => MockupIndexController());
    Get.lazyPut<MockupCreateController>(() => MockupCreateController());
    Get.lazyPut<MockupSingleController>(() => MockupSingleController());
    Get.lazyPut<BuildCreateMockupSidebarSelectedStateController>(
      () => BuildCreateMockupSidebarSelectedStateController(),
    );
    Get.lazyPut<ChangeFontfamilyController>(() => ChangeFontfamilyController());

    // mockup mictro
    Get.lazyPut<BoolToggleController>(() => BoolToggleController());
    Get.lazyPut<AlignmentOptionController>(() => AlignmentOptionController());
  }
}
