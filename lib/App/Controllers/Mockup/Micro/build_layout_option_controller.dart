import 'package:get/get.dart';

class BuildLayoutOptionController extends GetxController {
  final _activeLayout = ''.obs;
  String get activeLayout => _activeLayout.value;

  setActiveLayout({required String layout}) {
    _activeLayout.value = layout;
  }

  onEnter(String value) {
    setActiveLayout(layout: value);
  }

  onExit(String value) {
    setActiveLayout(layout: '');
  }
}
