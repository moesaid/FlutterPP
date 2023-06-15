import 'package:get/get.dart';

class MockupCreateController extends GetxController {
  // stepper
  final _currentStep = 0.obs;
  int get currentStep => _currentStep.value;

  // next step
  void onStepContinue() {
    if (_currentStep.value >= 2) return;

    _currentStep.value++;
    update();
  }

  // previous step
  void onStepCancel() {
    if (_currentStep.value <= 0) return;

    _currentStep.value--;
    update();
  }
}
