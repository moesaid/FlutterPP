import 'package:flutterpp/App/Controllers/Auth/login_controller.dart';
import 'package:flutterpp/App/Controllers/Auth/signup_controller.dart';
import 'package:flutterpp/App/Controllers/Auth/splash_controller.dart';
import 'package:flutterpp/App/Controllers/Auth/verify_otp_controller.dart';
import 'package:flutterpp/App/Controllers/Dashboard/dashboard_controller.dart';
import 'package:flutterpp/App/Controllers/Dashboard/dashboard_env_check_controller.dart';
import 'package:flutterpp/App/Controllers/Global/emoji_dialog_controller.dart';
import 'package:flutterpp/App/Controllers/Home/home_controller.dart';
import 'package:flutterpp/App/Controllers/Mockup/Micro/alignment_option_controller.dart';
import 'package:flutterpp/App/Controllers/Mockup/Micro/bool_toggle_controller.dart';
import 'package:flutterpp/App/Controllers/Mockup/Micro/build_layout_option_controller.dart';
import 'package:flutterpp/App/Controllers/Mockup/Micro/edit_frame_option_controller.dart';
import 'package:flutterpp/App/Controllers/Mockup/Micro/select_image_option_controller.dart';
import 'package:flutterpp/App/Controllers/Mockup/Micro/slider_option_controller.dart';
import 'package:flutterpp/App/Controllers/Mockup/build_create_mockup_sidebar_selected_state_controller.dart';
import 'package:flutterpp/App/Controllers/Mockup/change_fontfamily_controller.dart';
import 'package:flutterpp/App/Controllers/Mockup/mockup_create_controller.dart';
import 'package:flutterpp/App/Controllers/Mockup/mockup_index_controller.dart';
import 'package:flutterpp/App/Controllers/Mockup/mockup_single_controller.dart';
import 'package:flutterpp/App/Controllers/Mockup/pickup_color_controller.dart';
import 'package:flutterpp/App/Controllers/Team/no_team_controller.dart';
import 'package:flutterpp/Config/Bindings/Project/app_project_binding.dart';
import 'package:get/get.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    // permanent
    Get.put(HomeController(), permanent: true);

    // Auth
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<SignupController>(() => SignupController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<VerifyOtpController>(() => VerifyOtpController());

    // Dashboard
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<DashboardEnvCheckController>(
      () => DashboardEnvCheckController(),
    );

    // team
    Get.lazyPut<NoTeamController>(() => NoTeamController());

    // project
    AppProjectBinding.int();

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
    Get.lazyPut<PickupColorController>(() => PickupColorController());
    Get.lazyPut<EditFrameOptionController>(() => EditFrameOptionController());
    Get.lazyPut<BuildLayoutOptionController>(
      () => BuildLayoutOptionController(),
    );
    Get.lazyPut<EmojiDialogController>(() => EmojiDialogController());

    Get.lazyPut<SliderOptionController>(() => SliderOptionController());
    Get.lazyPut<SelectImageOptionController>(
      () => SelectImageOptionController(),
    );
  }
}
