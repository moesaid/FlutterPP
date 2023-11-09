import 'package:get/get.dart';

class AlignmentOptionController extends GetxController {
  final _alignment = AlignmentOptionEnum.left.obs;
  AlignmentOptionEnum get alignment => _alignment.value;

  void setAlignment(AlignmentOptionEnum alignment) {
    _alignment.value = alignment;
    update();
  }
}

enum AlignmentOptionEnum {
  left,
  center,
  right,
}
