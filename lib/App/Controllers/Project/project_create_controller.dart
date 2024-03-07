import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Models/team_model.dart';
import 'package:flutterpp/App/Services/Project/project_services.dart';
import 'package:flutterpp/App/Services/Project/wiki_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:flutterpp/App/Views/Global/build_snackbar.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:get/get.dart';

class ProjectCreateController extends GetxController {
  final _projectServices = ProjectServices();

  final _wikiServices = WikiServices();

  final _selectedColors = <Color>[].obs;
  List<Color> get selectedColors => _selectedColors;

  final _selectedSVG = ''.obs;
  String get selectedSVG => _selectedSVG.value;

  final _team = TeamModel().obs;
  TeamModel get team => _team.value;

  // set up controller
  void setUpController({required TeamModel team}) {
    _team.value = team;
    _selectedColors.addAll([Colors.red, Colors.blue]);
    _selectedSVG.value = 'fi-br-bread-slice.svg';
  }

  // on color change
  void onColorChange(List<Color> colors) {
    _selectedColors.clear();
    _selectedColors.addAll(colors);
    update();
  }

  // on svg change
  void onSvgChange(String svg) {
    _selectedSVG.value = svg;
    update();
  }

  // create project
  Future<void> createProject({
    required Map formData,
    required Function(ProjectModel) onCreateProject,
  }) async {
    // make sure icon and colors are selected
    if (_selectedSVG.value.isEmpty || _selectedColors.isEmpty) {
      BuildSnackBar(
        title: 'Error',
        message: 'Please select icon and colors',
      ).error();
      return;
    }

    // form data
    String title = formData['title'];
    String description = formData['description'];

    await Get.showOverlay(
      loadingWidget: const BuildOverlay(),
      asyncFunction: () async {
        ProjectModel? project = await _projectServices.createProject(
          teamId: team.id!,
          color1: ColorHelper.colorToHex(_selectedColors.first),
          color2: ColorHelper.colorToHex(_selectedColors.last),
          icon: _selectedSVG.value,
          title: title,
          description: description,
        );

        // if project is null
        if (project!.id == null) return;

        // project callback
        onCreateProject.call(project);

        await _wikiServices.createWiki(
          title: 'default',
          projectId: project.id!,
          document: _wikiServices.getDefultDocument,
        );
      },
    );
  }
}
