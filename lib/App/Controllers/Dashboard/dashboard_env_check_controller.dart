import 'package:flutterpp/App/Services/Cmd/cmd_env_services.dart';
import 'package:get/get.dart';

class DashboardEnvCheckController extends GetxController {
  CmdEnvServices cmdEnvServices = CmdEnvServices();
  checkEnv() async {
    await cmdEnvServices.checkEnv();
  }
}
