import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Services/Project/project_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:get/get.dart';

class ProjectSingleEditController extends GetxController {
  final ProjectServices _projectServices = ProjectServices();

  final _activeIcon = 'fi-br-barber-shop.svg'.obs;
  String get activeIcon => _activeIcon.value;

  final _activeColors = <String>['#000,#000'].obs;
  List<String> get activeColors => _activeColors;

  // update colors
  void updateColors(List<Color> items) {
    _activeColors.value = items.map((e) => ColorHelper.colorToHex(e)).toList();
    update();
  }

  // update icon
  void updateIcon(String val) {
    _activeIcon.value = val;
    update();
  }

  // update project
  Future<ProjectModel?> updateProject({
    required ProjectModel project,
  }) async {
    ProjectModel item = project.copyWith(
      icon: activeIcon,
      color1: activeColors[0],
      color2: activeColors[1],
    );

    ProjectModel? newProject = await Get.showOverlay(
      asyncFunction: () async {
        return await _projectServices.updateProject(project: item);
      },
      loadingWidget: const BuildOverlay(),
    );

    // update active icon and colors
    if (newProject != null) {
      _activeIcon.value = newProject.icon!;
      _activeColors.value = [newProject.color1!, newProject.color2!];
      update();
    }

    return newProject;
  }
}
