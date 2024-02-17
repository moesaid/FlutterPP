import 'package:get_storage/get_storage.dart';

class LocalFlutterPath {
  final String _key = 'local_flutter_path';
  final GetStorage _box = GetStorage();

  // read
  String? read() {
    return _box.read(_key);
  }

  // write
  Future<void> write(String path) async {
    await _box.write(_key, path);
  }

  // remove
  Future<void> remove() async {
    await _box.remove(_key);
  }
}
