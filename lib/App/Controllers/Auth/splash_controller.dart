import 'package:flutterpp/App/Services/Auth/auth_services.dart';
import 'package:flutterpp/App/Services/Team/team_services.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashController extends GetxController {
  final AuthServices _authServices = AuthServices();
  final TeamServices _teamServices = TeamServices();

  final supabase = Supabase.instance.client;

  final _version = ''.obs;
  String get version => _version.value;

  final _isInTeam = false.obs;
  bool get isInTeam => _isInTeam.value;

  final _isValideInvite = false.obs;
  bool get isValideInvite => _isValideInvite.value;

  @override
  Future<void> onReady() async {
    await _getVersion();
    await _nextPage();
    super.onReady();
  }

  _nextPage() async {
    final Session? session = supabase.auth.currentSession;

    Future.delayed(const Duration(seconds: 2), () async {
      if (session != null) {
        await _splashCheckList();
      } else {
        Get.offNamed(AppRoutes.SIGNUP);
      }
    });
  }

  // get version
  _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;

    if (version.isEmpty) return;

    _version.value = version;
    update();
  }

  // splash check list
  _splashCheckList() async {
    await _checkIfUserIsInTeam();

    if (!_isInTeam.value) {
      Get.offNamed(AppRoutes.No_TEAM);
      return;
    }

    Get.offNamed(AppRoutes.HOME);
  }

  // check if user is in team
  Future<void> _checkIfUserIsInTeam() async {
    User? user = _authServices.currentUser();
    if (user == null) return;

    bool isInTeam = await _teamServices.isUserInTeam(user.id);
    _isInTeam.value = isInTeam;
    update();
  }
}
