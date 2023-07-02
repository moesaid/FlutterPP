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
  BackgroundTypeModel get activeBackgroundType =>
      _backgroundTypeList.firstWhere((el) => el.isSelected == true);

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
    update();
  }

  updateSelectedTitle(String title) {
    _selectedTitle.value = title;
    update();
  }
}

class BackgroundTypeModel {
  final String? name, id;
  late bool? isSelected;

  BackgroundTypeModel({
    this.name,
    this.isSelected = false,
    this.id,
  });

  BackgroundTypeModel.fromJson(
    Map<String, dynamic> json,
    this.name,
    this.isSelected,
    this.id,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['isSelected'] = isSelected;
    return data;
  }
}
