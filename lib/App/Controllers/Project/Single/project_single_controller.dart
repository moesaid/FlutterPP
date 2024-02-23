import 'dart:math';

import 'package:flutterpp/App/Controllers/Dashboard/dashboard_controller.dart';
import 'package:flutterpp/App/Models/project_local_path_model.dart';
import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Services/Cmd/cmd_init_getx_mvc_services.dart';
import 'package:flutterpp/App/Services/Cmd/cmd_read_create_dir_services.dart';
import 'package:flutterpp/App/Services/Project/create_load_project_path.dart';
import 'package:flutterpp/App/Services/Project/project_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:flutterpp/Storage/local_flutter_path.dart';
import 'package:flutterpp/Storage/projects_local_path_storage.dart';
import 'package:get/get.dart';

class ProjectSingleController extends GetxController {
  final ProjectServices _projectServices = ProjectServices();
  final CmdReadCreateDirServices _cmd = CmdReadCreateDirServices();
  final CreateLoadProjectPathServices _createLoadServices =
      CreateLoadProjectPathServices();
  final ProjectsLocalPathStorage _projectLocalPathStorage =
      ProjectsLocalPathStorage();

  final CmdInitGetxMvcServices _cmdInitGetxMvcServices =
      CmdInitGetxMvcServices();

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _project = ProjectModel().obs;
  ProjectModel get project => _project.value;

  final _projectLocalPath = ''.obs;
  String get projectLocalPath => _projectLocalPath.value;

  final _isFlutterPPProject = false.obs;
  bool get isFlutterPPProject => _isFlutterPPProject.value;

  @override
  void onClose() {
    _project.value = ProjectModel();
    _projectLocalPath.value = '';
    _isFlutterPPProject.value = false;

    super.onClose();
  }

  // fetch api
  fetchApi({String? projectId}) async {
    // if project id is empty
    if (projectId == null || projectId.isEmpty) {
      _isLoading.value = false;
      update();
      return;
    }

    // fetch project
    ProjectModel? project = await _projectServices.getProjectById(
      projectId: projectId,
    );

    if (project == null) {
      _isLoading.value = false;
      update();
      return;
    }

    _project.value = project;

    await _fetchLocalPath();
    await checkIfFlutterPPProject();

    _isLoading.value = false;
    update();
  }

  // fetch local path
  _fetchLocalPath() {
    if (project.id == null || project.id!.isEmpty) return;

    ProjectLocalPathModel? item = _projectLocalPathStorage.readById(
      projectId: project.id!,
    );
    if (item != null) {
      _projectLocalPath.value = item.path ?? '';
      update();
    }
  }

  // set local path
  loadProjectPath() async {
    // check if flutter path is available
    if (!checkFlutterPath()) {
      Get.toNamed(AppRoutes.SETUP_LOCAL_FLUTTER_PATH);
      return;
    }

    // if project id is empty
    if (project.id == null || project.id!.isEmpty) return;

    await _createLoadServices.loadProjectPath(id: project.id!);
    await _fetchLocalPath();
    await checkIfFlutterPPProject();
  }

  // check if project is flutterpp project
  Future<bool> checkIfFlutterPPProject() async {
    if (project.id == null || project.id!.isEmpty) return false;
    _isFlutterPPProject.value = await _cmd.isFlutterPPProject(projectLocalPath);
    update();

    return isFlutterPPProject;
  }

  // create project path
  Future<void> createProjectPath() async {
    // check if flutter path is available
    if (!checkFlutterPath()) {
      Get.toNamed(AppRoutes.SETUP_LOCAL_FLUTTER_PATH);
      return;
    }

    // if project id is empty
    if (project.id == null || project.id!.isEmpty) return;

    Get.showOverlay(
      asyncFunction: () async {
        String? path = await _cmdInitGetxMvcServices.createProject(
          _project.value.title ?? 'NewFlutterPP${Random().nextInt(100)}',
        );

        if (path == null) return;

        // save project path
        await _projectLocalPathStorage.write(
          project: ProjectLocalPathModel(
            id: project.id,
            path: path,
          ),
        );

        // fetch local path
        await _fetchLocalPath();

        // check if project is flutterpp project
        await checkIfFlutterPPProject();
      },
      loadingWidget: const BuildOverlay(),
    );
  }

  // remove project path
  removeProjectPath() {
    if (project.id == null || project.id!.isEmpty) return;
    _projectLocalPathStorage.removeById(projectId: project.id!);
    _projectLocalPath.value = '';
    update();
  }

  void updateProject(ProjectModel item) {
    _project.value = item;
    update();

    // check if dashboard controller is available
    if (Get.isRegistered<DashboardController>()) {
      Get.find<DashboardController>().updateProjectList(item);
    }
  }

  // check flutter path
  bool checkFlutterPath() {
    // get local path
    String? localPath = LocalFlutterPath().read();

    if (localPath == null || localPath.isEmpty) {
      return false;
    }

    return true;
  }
}
