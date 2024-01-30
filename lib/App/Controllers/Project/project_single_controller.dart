import 'package:flutterpp/App/Models/project_model.dart';
import 'package:get/get.dart';

class ProjectSingleController extends GetxController {
  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _project = ProjectModel().obs;
  ProjectModel get project => _project.value;

  @override
  Future<void> onInit() async {
    await _fetchApi();
    super.onInit();
  }

  _fetchApi() {}
}
