import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Home/home_controller.dart';
import 'package:flutterpp/App/Models/profile_model.dart';
import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Models/team_member_model.dart';
import 'package:flutterpp/App/Models/team_model.dart';
import 'package:flutterpp/App/Services/Auth/profile_services.dart';
import 'package:flutterpp/App/Services/Project/project_services.dart';
import 'package:flutterpp/App/Services/Team/team_member_services.dart';
import 'package:flutterpp/App/Services/Team/team_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:flutterpp/App/Views/Global/build_snackbar.dart';
import 'package:flutterpp/Config/app_gradients.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:flutterpp/Storage/active_project_storage.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final _teamServices = TeamServices();
  final _projectServices = ProjectServices();
  final _activeProjectStorage = ActiveProjectStorage();
  final _teamMemberServices = TeamMemberServices();
  final _profileServices = ProfileServices();

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _team = TeamModel().obs;
  TeamModel get team => _team.value;

  final _projects = <ProjectModel>[].obs;
  List<ProjectModel> get projects => _projects;

  final _activeProject = ProjectModel().obs;
  ProjectModel get activeProject => _activeProject.value;

  final _teamMembers = <TeamMemberModel>[].obs;
  List<TeamMemberModel> get teamMembers => _teamMembers;

  final _profile = ProfileModel().obs;
  ProfileModel get profile => _profile.value;

  final _colors = <List<Color>>[].obs;
  List<List<Color>> get colors => _colors;

  final _selectedColors = <Color>[].obs;
  List<Color> get selectedColors => _selectedColors;

  final _oreginalSelectedColors = <String>[].obs;
  List<String> get oreginalSelectedColors => _oreginalSelectedColors;

  final _svgs = <String>[].obs;
  List<String> get svgs => _svgs;

  final _selectedSVG = ''.obs;
  String get selectedSVG => _selectedSVG.value;

  @override
  Future<void> onInit() async {
    _listOfColors();
    _listOFSVGs();
    await _getAuthProfile();
    await _fetchTeamAndProjects();
    await _fetchActiveProject();
    await _getTeamMembers();
    _updateLoading(false);
    super.onInit();
  }

  // fetch team and projects
  Future<void> _fetchTeamAndProjects() async {
    TeamModel? team = await _teamServices.getTeamForAuthUser();

    if (team == null || team.id == null) return;

    List<ProjectModel>? projects = await _projectServices.getProjects(
      teamId: team.id!,
    );

    _team.value = team;

    if (projects == null || projects.isEmpty) return;

    _projects.value = projects;
  }

  // fetch active project
  Future<void> _fetchActiveProject() async {
    ProjectModel? item = _activeProjectStorage.read();

    //  if null add first project to active project
    item ??= await _activeProjectStorage.write(_projects.first);

    _activeProject.value = item;
  }

  // update active project
  Future<void> updateActiveProject(ProjectModel project) async {
    _activeProject.value = project;
    await _activeProjectStorage.write(project);
    update();
  }

  // update loading
  void _updateLoading(bool bool) {
    _isLoading.value = bool;
    update();
  }

  // create project
  Future<void> createProject({required Map formData}) async {
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

        _projects.add(project!);
        update();
      },
    );

    Get.back();
  }

  // list of colors
  void _listOfColors() {
    var localColors = AppGradients.getRandomColors();
    _colors.addAll(localColors);
    update();

    onColorChange(localColors[Random().nextInt(localColors.length)]);
  }

  // list of svg
  _listOFSVGs() async {
    final manifestJson = await DefaultAssetBundle.of(Get.context!)
        .loadString('AssetManifest.json');
    final allFiles = json
        .decode(manifestJson)
        .keys
        .where((String key) => key.startsWith('assets/svg'))
        .toList();

    // remover what not ends with .svg
    allFiles.removeWhere((element) => !element.endsWith('.svg'));

    // remove assets/svg/
    List svgs = allFiles.map((e) => e.replaceFirst('assets/svg/', '')).toList();

    // convert each item in the array to a string
    List<String> arr = svgs.map((e) => e.toString()).toList();

    // add to _svgs
    _svgs.addAll(arr);
    update();

    // set random svg
    onSVGChange(_svgs[Random().nextInt(_svgs.length)]);
  }

  // on color change
  void onColorChange(List<Color> colors) {
    // from colors to hexcolor
    List<String> hexColors = colors
        .map(
          (e) => ColorHelper.colorToHex(e),
        )
        .toList();

    // set selected colors
    _selectedColors.value = colors;
    _oreginalSelectedColors.value = hexColors;
    update();
  }

  // on svg change
  void onSVGChange(String svg) {
    _selectedSVG.value = svg;
    update();
  }

  // get team members
  _getTeamMembers() async {
    if (team.id == null) return;

    List<TeamMemberModel>? items = await _teamMemberServices.getTeamMembers(
      teamId: team.id!,
    );

    if (items == null || items.isEmpty) return;

    _teamMembers.assignAll(items);
  }

  // get auth user
  _getAuthProfile() async {
    _profile.value = (await _profileServices.getAuthProfile())!;
  }

  // navigate to project
  void navigateToProject(ProjectModel project) {
    // if project is active project
    if (project.id == activeProject.id) {
      HomeController homeController = Get.find();

      homeController.changeProjectValues(activeProject: project);
      int index = homeController.tabs.indexWhere(
        (el) => el['type'] == 'project',
      );

      homeController.changeTab(index);

      return;
    }

    // got to single project page
    Get.toNamed(AppRoutes.PROJECT_SINGLE, parameters: {
      'projectId': project.id!,
    });
  }
}
