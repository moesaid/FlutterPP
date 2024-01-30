import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Services/Project/project_services.dart';
import 'package:get/get.dart';

class ProjectSingleController extends GetxController {
  final ProjectServices _projectServices = ProjectServices();

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  String projectId = Get.parameters['projectId'] ?? '';

  final _project = ProjectModel().obs;
  ProjectModel get project => _project.value;

  @override
  Future<void> onInit() async {
    await _fetchApi();
    super.onInit();
  }

  _fetchApi() async {
    // if project id is empty
    if (projectId.isEmpty) {
      _isLoading.value = false;
      update();
      return;
    }

    // fetch project
    ProjectModel? project =
        await _projectServices.getProjectById(projectId: projectId);

    if (project == null) {
      _isLoading.value = false;
      update();
      return;
    }

    _project.value = project;
    _isLoading.value = false;
    update();
  }
}
