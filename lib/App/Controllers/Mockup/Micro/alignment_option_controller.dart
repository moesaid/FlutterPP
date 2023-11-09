import 'package:flutterpp/App/Enums/alignment_option_enum.dart';
import 'package:get/get.dart';

class AlignmentOptionController extends GetxController {
  final _alignment = AlignmentOptionEnum.left.obs;
  AlignmentOptionEnum get alignment => _alignment.value;

  void setAlignment({
    required AlignmentOptionEnum alignment,
    Function(AlignmentOptionEnum)? onToggle,
  }) {
    _alignment.value = alignment;
    update();

    onToggle?.call(alignment);
  }
}
