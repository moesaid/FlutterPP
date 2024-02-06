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

  final _tempModel = ModelConfigModel().obs;
  ModelConfigModel get tempModel => _tempModel.value;

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

    // check if res is null
    if (res == null) return;

    _models.assignAll(res);
    for (var item in _models) {
      List<EdgeInput> nextItems = [];

      if (item.relations != null && item.relations!.isNotEmpty) {
        for (var relation in item.relations!) {
          // get relation model id
          String? relationModelId =
              _models.firstWhere((el) => el.modelName == relation.name).id;

          nextItems.add(EdgeInput(outcome: relationModelId!));
        }
      }

      // add to nodes
      _nodes.add(NodeInput(id: item.id!, next: nextItems));
    }

    update();
  }

  // update temp model
  void updateTempModel(ModelConfigModel model) {
    _tempModel.value = _tempModel.value.copyWith(
      id: model.id,
      modelName: model.modelName,
      color: model.color,
      isCrud: model.isCrud,
      relations: model.relations,
      properties: model.properties,
    );

    update();
  }
}
