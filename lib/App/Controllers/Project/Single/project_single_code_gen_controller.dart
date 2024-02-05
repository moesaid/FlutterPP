import 'package:flutterpp/App/Controllers/Project/Single/project_single_controller.dart';
import 'package:flutterpp/App/Models/model_config_model.dart';
import 'package:flutterpp/App/Services/Project/project_model_services.dart';
import 'package:get/get.dart';
import 'package:graphite/graphite.dart';

class ProjectSingleCodeGenController extends GetxController {
  late ProjectSingleController useController;

  final ProjectModelServices _projectModelServices = ProjectModelServices();

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _models = <ModelConfigModel>[].obs;
  List<ModelConfigModel> get models => _models;

  final _nodes = <NodeInput>[].obs;
  List<NodeInput> get nodes => _nodes;

  @override
  Future<void> onInit() async {
    await _findControllers();
    await fetchApi();

    _isLoading.value = false;
    update();
    super.onInit();
  }

  _findControllers() {
    if (Get.isRegistered<ProjectSingleController>()) {
      useController = Get.find<ProjectSingleController>();
    }
  }

  Future<void> fetchApi() async {
    List<ModelConfigModel>? res = await _projectModelServices.getProjectById(
      projectId: useController.project.id,
    );

    print(res);
  }
}
