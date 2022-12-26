import 'package:get_storage/get_storage.dart';

class UserToken {
  final box = GetStorage();

  // read token
  Future<String> read() async {
    String? value = box.read('token');

    return value ?? '';
  }

  // write token
  Future<void> write(String token) async {
    await box.write('token', token);
  }

  // delete token
  Future<void> remove() async {
    await box.remove('token');
  }
}
