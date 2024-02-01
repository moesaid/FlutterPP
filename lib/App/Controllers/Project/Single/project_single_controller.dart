import 'package:flutterpp/App/Models/project_local_path_model.dart';
import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Services/Cmd/cmd_read_create_dir_services.dart';
import 'package:flutterpp/App/Services/Project/create_load_project_path.dart';
import 'package:flutterpp/App/Services/Project/project_services.dart';
import 'package:flutterpp/Storage/projects_local_path_storage.dart';
import 'package:get/get.dart';

class ProjectSingleController extends GetxController {
  final ProjectServices _projectServices = ProjectServices();
  final CmdReadCreateDirServices _cmd = CmdReadCreateDirServices();
  final CreateLoadProjectPathServices _createLoadServices =
      CreateLoadProjectPathServices();
  final ProjectsLocalPathStorage _projectLocalPathStorage =
      ProjectsLocalPathStorage();

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _project = ProjectModel().obs;
  ProjectModel get project => _project.value;

  final _projectLocalPath = ''.obs;
  String get projectLocalPath => _projectLocalPath.value;

  final _isFlutterPPProject = false.obs;
  bool get isFlutterPPProject => _isFlutterPPProject.value;

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
    if (project.id == null || project.id!.isEmpty) return;
    await _createLoadServices.loadProjectPath(id: project.id!);
    await checkIfFlutterPPProject();
  }

  // check if project is flutterpp project
  checkIfFlutterPPProject() async {
    if (project.id == null || project.id!.isEmpty) return;
    _isFlutterPPProject.value = await _cmd.isFlutterPPProject(projectLocalPath);
    update();
  }

  // create project path
  createProjectPath() {}

  // remove project path
  removeProjectPath() {
    if (project.id == null || project.id!.isEmpty) return;
    _projectLocalPathStorage.removeById(projectId: project.id!);
    _projectLocalPath.value = '';
    update();
  }
}
