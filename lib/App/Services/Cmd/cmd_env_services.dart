import 'dart:convert';

import 'package:flutterpp/App/Models/check_env_model.dart';
import 'package:flutterpp/App/Providers/Cmd/cmd_env_provider.dart';

class CmdEnvServices {
  CmdEnvProvider cmdEnvProvider = CmdEnvProvider();

  // check env
  Future<CheckEnvModel>? checkEnv() async {
    bool? isDart = await cmdEnvProvider.checkDartInstallation();
    bool? isFlutter = await cmdEnvProvider.checkFlutterInstallation();
    String? flutterVersion = await cmdEnvProvider.checkFlutterVersion();
    String? dartVersion = await cmdEnvProvider.checkDartVersion();
    List<Map<String, dynamic>>? resDoc =
        await cmdEnvProvider.runFlutterDoctor();

    Map<String, dynamic> res = {
      'dart_installed': isDart,
      'flutter_installed': isFlutter,
      'flutter_version': flutterVersion,
      'dart_version': dartVersion,
      'flutter_doctor': resDoc,
    };

    // convert to json
    var localJson = json.encode(res);

    return CheckEnvModel.fromJson(json.decode(localJson));
  }
}
