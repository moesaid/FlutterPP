import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Models/team_model.dart';
import 'package:flutterpp/App/Services/Project/project_services.dart';
import 'package:flutterpp/App/Services/Team/team_services.dart';
import 'package:flutterpp/App/Views/Global/build_snackbar.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:get/get.dart';

class MockupCreateController extends GetxController {
  final ProjectServices _projectServices = ProjectServices();
  final TeamServices _teamServices = TeamServices();

  final _activeIcon = 'fi-br-a.svg'.obs;
  String get activeIcon => _activeIcon.value;

  final _activeGradient = <Color>[
    const Color(0xff4d80cc),
    const Color(0xffcc80cc),
  ].obs;
  List<Color> get activeGradient => _activeGradient;

  final _title = ''.obs;
  String get title => _title.value;

  final _description = ''.obs;
  String get description => _description.value;

  final _category = ''.obs;
  String get category => _category.value;

  // list of projects
  final _projects = <ProjectModel>[].obs;
  List<ProjectModel> get projects => _projects;

  final _selectedProject = ProjectModel().obs;
  ProjectModel get selectedProject => _selectedProject.value;

  // auth team
  final _team = TeamModel().obs;
  TeamModel get team => _team.value;

  // stepper
  final _currentStep = 0.obs;
  int get currentStep => _currentStep.value;

  // template id
  final _templateId = 'spotify'.obs;
  String get templateId => _templateId.value;

  @override
  void onReady() {
    _fetchApi();
    super.onReady();
  }

  // next step
  void onStepContinue() {
    // if going to step 1 make sure title & description & category is not empty
    if (_currentStep.value == 0) {
      if (_title.value.isEmpty ||
          _description.value.isEmpty ||
          _category.value.isEmpty) {
        BuildSnackBar(
          title: 'Error',
          message: 'Please fill all fields',
        ).error();
        return;
      }
    }

    // if going to step 2 and user has no has no projects
    if (_currentStep.value == 0 && _projects.isEmpty) {
      print('no projects');
      _currentStep.value = 2;
      update();
      return;
    }

    // if in step 2 and going to step 3
    // make sure user has selected a project
    if (_currentStep.value == 1 && _selectedProject.value.id == null) {
      BuildSnackBar(
        title: 'Error',
        message: 'Please select a project',
      ).error();
      return;
    }

    // if last step return
    if (_currentStep.value >= 2) {
      // Todo: create mockup

      // got to single mockup page
      Get.offAndToNamed(AppRoutes.MOCKUP_SINGLE, arguments: {
        'mockupId': 'mockupId',
      });
      return;
    }

    _currentStep.value++;
    update();
  }

  // previous step
  void onStepCancel() {
    if (_currentStep.value <= 0) return;

    // if going to step 2 and user has no has no projects
    if (_currentStep.value == 2 && _projects.isEmpty) {
      _currentStep.value = 0;
      update();
      return;
    }

    _currentStep.value--;
    update();
  }

  // set active icon
  void onIconChange(String icon) {
    _activeIcon.value = icon;
    update();
  }

  // set active gradient
  void onGradientChange(List<Color> gradient) {
    _activeGradient.value = gradient;
    update();
  }

  // update title or description or category
  void onTitleOrDescriptionOrCategory({
    required String type,
    required String value,
  }) {
    if (type == 'title') {
      _title.value = value;
    } else if (type == 'description') {
      _description.value = value;
    } else if (type == 'category') {
      _category.value = value;
    }
  }

  // set selected project
  onProjectChange(ProjectModel project) {
    _selectedProject.value = project;
  }

  Future<void> _fetchApi() async {
    // get team
    TeamModel? localTeam = await _teamServices.getTeamForAuthUser();
    if (localTeam == null) return;
    _team.value = localTeam;

    // get projects
    List<ProjectModel>? localProjects =
        await _projectServices.getProjects(teamId: localTeam.id!);

    if (localProjects == null) return;
    _projects.addAll(localProjects);
    update();

    print({
      '❌ team': _team.value,
      'projects': _projects,
    });
  }

  // update template id
  void onTemplateChange(String templateId) {
    _templateId.value = templateId;
    update();

    print('templateId: $templateId');
  }
}
