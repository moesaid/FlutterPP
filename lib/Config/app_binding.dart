import 'package:flutterpp/App/Controllers/x_controller.dart';
import 'package:get/get.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<xController>(() => xController());
  }
}
