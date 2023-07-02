import 'package:get/get.dart';

class BuildCreateMockupSidebarSelectedStateController extends GetxController {
  final _selectedTitle = 'one'.obs;
  String get selectedTitle => _selectedTitle.value;

  updateSelectedTitle(String title) {
    _selectedTitle.value = title;
    update();
  }
}
