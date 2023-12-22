import 'package:get/get.dart';

class SliderOptionController extends GetxController {
  final _sliderValue = 0.0.obs;
  double get sliderValue => _sliderValue.value;

  // on change callback
  void onChange({
    required double value,
    Function(double value)? callback,
  }) {
    _sliderValue.value = value;
    update();

    if (callback != null) {
      callback(value);
    }
  }
}
