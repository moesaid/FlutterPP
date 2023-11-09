import 'package:flutterpp/App/Models/background_type_model.dart';
import 'package:get/get.dart';

class BuildCreateMockupSidebarSelectedStateController extends GetxController {
  final _selectedTitle = 'one'.obs;
  String get selectedTitle => _selectedTitle.value;

  final _backgroundTypeList = <BackgroundTypeModel>[
    BackgroundTypeModel(id: 'solid', name: 'solid color', isSelected: true),
    BackgroundTypeModel(id: 'gradient', name: 'gradient', isSelected: false),
    BackgroundTypeModel(id: 'image', name: 'image', isSelected: false),
  ].obs;

  List<BackgroundTypeModel> get backgroundTypeList => _backgroundTypeList;

  // active background type
  final _activeBackgroundType = BackgroundTypeModel().obs;
  BackgroundTypeModel get activeBackgroundType => _activeBackgroundType.value;

  // on select background type change
  void onSelectBackgroundType({
    required String name,
  }) {
    for (var element in _backgroundTypeList) {
      if (element.name == name) {
        element.isSelected = true;
      } else {
        element.isSelected = false;
      }
    }

    _activeBackgroundType.value =
        _backgroundTypeList.firstWhere((el) => el.isSelected == true);
    // update();
  }

  updateSelectedTitle(String title) {
    _selectedTitle.value = title;
    update();
  }
}
