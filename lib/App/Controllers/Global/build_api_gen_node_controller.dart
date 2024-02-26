import 'package:get/get.dart';

class BuildApiGenNodeController extends GetxController {
  final _isHovring = false.obs;
  bool get isHovring => _isHovring.value;

  final _isPlusHovering = false.obs;
  bool get isPlusHovering => _isPlusHovering.value;

  // toggle hovring
  void toggleHovring(val) {
    _isHovring.value = val;
    update();
  }

  // toggle plus hovring
  void togglePlusHovring(val) {
    _isPlusHovering.value = val;
    update();
  }
}
