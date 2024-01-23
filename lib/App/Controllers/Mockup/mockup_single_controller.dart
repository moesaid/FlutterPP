import 'package:flutterpp/App/Models/mockup_model.dart';
import 'package:get/get.dart';

class MockupSingleController extends GetxController {
  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _mockup = MockupModel().obs;
  MockupModel get mockup => _mockup.value;

  @override
  void onInit() {
    _getMockup();

    super.onInit();
  }

  void _getMockup() {
    _mockup.value = Get.arguments as MockupModel;
    _isLoading.value = false;
    update();
  }
}
