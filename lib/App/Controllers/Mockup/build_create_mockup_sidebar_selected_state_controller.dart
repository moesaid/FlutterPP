import 'package:flutterpp/App/Enums/background_enum.dart';
import 'package:flutterpp/App/Models/background_type_model.dart';
import 'package:flutterpp/App/Models/gradient_model.dart';
import 'package:get/get.dart';

class BuildCreateMockupSidebarSelectedStateController extends GetxController {
  final _selectedTitle = 'one'.obs;
  String get selectedTitle => _selectedTitle.value;

  final _gradientName = 'select gradient'.obs;
  String get gradientName => _gradientName.value;

  final _activeGradient = GradientModel().obs;
  GradientModel get activeGradient => _activeGradient.value;

  final _backgroundTypeList = <BackgroundTypeModel>[
    BackgroundTypeModel(
      id: BackgroundEnum.solid.id,
      name: 'solid color',
      isSelected: true,
    ),
    BackgroundTypeModel(
      id: BackgroundEnum.gradient.id,
      name: 'gradient',
      isSelected: false,
    ),
    BackgroundTypeModel(
      id: BackgroundEnum.image.id,
      name: 'image',
      isSelected: false,
    ),
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

    updateActive();
  }

  // update selected title
  updateSelectedTitle(String title) {
    _selectedTitle.value = title;
    update();
  }

  // on change background type
  void updateActive() {
    _activeBackgroundType.value =
        _backgroundTypeList.firstWhere((el) => el.isSelected == true);
  }

  // on gradient select
  void onGradientSelect(GradientModel item) {
    _activeGradient.value = item;
    _gradientName.value = item.name ?? 'select gradient';
    update();

    Get.back();
  }

  // update angle
  void updateAngle(double angle) {
    _activeGradient.value.angle = angle;
  }

  onSelectImage(String el) {}
}
