import 'package:get/get.dart';

class BoolToggleController extends GetxController {
  final _isOn = false.obs;
  bool get isOn => _isOn.value;

  bool toggle() {
    _isOn.value = !_isOn.value;
    update();

    return _isOn.value;
  }
}
