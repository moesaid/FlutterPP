import 'package:flutterpp/App/Models/check_env_model.dart';
import 'package:get_storage/get_storage.dart';

class DeviceEnvStateStorage {
  GetStorage box = GetStorage();
  final String key = 'deviceEnvState';

  // read
  CheckEnvModel? read() {
    // read json from box
    var json = box.read(key);

    // if json is null return null
    if (json == null) return null;

    // return project model from json
    return CheckEnvModel.fromJson(json);
  }

  // write
  Future<CheckEnvModel> write(CheckEnvModel checkEnvModel) async {
    // write json to box
    await box.write(key, checkEnvModel.toJson());

    // return project
    return read()!;
  }

  // remove
  Future<void> remove() async {
    await box.remove(key);
  }
}
