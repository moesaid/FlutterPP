import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutterpp/App/Models/check_env_model.dart';
import 'package:flutterpp/App/Services/Cmd/cmd_env_services.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:flutterpp/Storage/device_env_state_storage.dart';
import 'package:flutterpp/Storage/local_flutter_path.dart';
import 'package:get/get.dart';

class DashboardEnvCheckController extends GetxController {
  final CmdEnvServices cmdEnvServices = CmdEnvServices();
  final DeviceEnvStateStorage deviceEnvStateStorage = DeviceEnvStateStorage();
  final LocalFlutterPath _localFlutterPath = LocalFlutterPath();

  final _isHovring = false.obs;
  bool get isHovring => _isHovring.value;

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _checkEnvModel = CheckEnvModel().obs;
  CheckEnvModel get checkEnvModel => _checkEnvModel.value;

  final _deviceName = ''.obs;
  String get deviceName => _deviceName.value;

  final _deviceModel = ''.obs;
  String get deviceModel => _deviceModel.value;

  @override
  Future<void> onInit() async {
    getDeviceInfo();
    await _checkLocalEnv();
    updateLoading(false);

    super.onInit();
  }

  // check local env
  Future<void> _checkLocalEnv() async {
    CheckEnvModel? res = deviceEnvStateStorage.read();
    if (res == null) return;

    _checkEnvModel.value = res;
  }

  // check env
  Future<void> _checkEnv() async {
    CheckEnvModel? res = await cmdEnvServices.checkEnv();
    if (res == null) return;

    _checkEnvModel.value = res;
    await deviceEnvStateStorage.write(res);
  }

  // recheck env
  Future<void> recheckEnv() async {
    // get local path
    String? localPath = _localFlutterPath.read();

    if (localPath == null || localPath.isEmpty) {
      Get.toNamed(AppRoutes.SETUP_LOCAL_FLUTTER_PATH);
      return;
    }

    updateLoading(true);

    await _checkEnv();

    updateLoading(false);
  }

  // device info
  Future<void> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    if (GetPlatform.isMacOS) {
      await deviceInfoPlugin.macOsInfo.then((value) {
        _deviceName.value = value.computerName;
        _deviceModel.value = value.model;
      });
    }

    if (GetPlatform.isWindows) {
      await deviceInfoPlugin.windowsInfo.then((value) {
        _deviceName.value = value.computerName;
        _deviceModel.value = value.registeredOwner;
      });
    }

    if (GetPlatform.isLinux) {
      await deviceInfoPlugin.linuxInfo.then((value) {
        _deviceName.value = value.name;
        _deviceModel.value = value.variant ?? value.version ?? '';
      });
    }
  }

  // update loading
  void updateLoading(bool value) {
    _isLoading.value = value;
  }

  // update is hovring
  void updateIsHovring(bool value) {
    _isHovring.value = value;
  }
}
