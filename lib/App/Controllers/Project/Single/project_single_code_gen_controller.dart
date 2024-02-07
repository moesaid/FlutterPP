import 'package:flutter_platform_alert/flutter_platform_alert.dart';
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

    _nodes.clear();
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
    );

    update();
  }

  // add relation to temp model
  Future<void> addRelationToTempModel(Relations relation) async {
    _tempModel.value.relations ??= [];

    // check if relation already exists
    if (_tempModel.value.relations!.any((el) => el.name == relation.name)) {
      await FlutterPlatformAlert.playAlertSound();

      await FlutterPlatformAlert.showAlert(
        windowTitle: 'Oops!',
        text: 'Relation already exists!, cannot add again.',
        alertStyle: AlertButtonStyle.ok,
        iconStyle: IconStyle.error,
      );
      return;
    }

    _tempModel.value = _tempModel.value.copyWith(
      relations: [
        ..._tempModel.value.relations!,
        relation,
      ],
    );
    update();
  }

  void addPropertiesToTempModel(Properties val) {
    _tempModel.value.properties ??= [];

    // if same property already exists
    if (_tempModel.value.properties!
        .any((el) => el.name == val.name?.toLowerCase().replaceAll(' ', ''))) {
      FlutterPlatformAlert.playAlertSound();
      FlutterPlatformAlert.showAlert(
        windowTitle: 'Oops!',
        text: 'Property already exists!, cannot add again.',
        alertStyle: AlertButtonStyle.ok,
        iconStyle: IconStyle.error,
      );
      return;
    }

    _tempModel.value = _tempModel.value.copyWith(
      properties: [
        ..._tempModel.value.properties!,
        val,
      ],
    );

    update();
  }

  // remove relation from temp model
  void removePropertiesFromTempModel(int index) {
    _tempModel.value.properties!.removeAt(index);
    update();
  }

  // create project model
  Future<void> createProjectModel() async {
    // name should not be empty
    if (_tempModel.value.modelName == null ||
        _tempModel.value.modelName!.isEmpty) {
      FlutterPlatformAlert.playAlertSound();
      FlutterPlatformAlert.showAlert(
        windowTitle: 'Oops!',
        text: 'Model name cannot be empty!',
        alertStyle: AlertButtonStyle.ok,
        iconStyle: IconStyle.error,
      );
      return;
    }

    // must have at least one property
    if (_tempModel.value.properties == null ||
        _tempModel.value.properties!.isEmpty) {
      FlutterPlatformAlert.playAlertSound();
      FlutterPlatformAlert.showAlert(
        windowTitle: 'Oops!',
        text: 'Model must have at least one property!',
        alertStyle: AlertButtonStyle.ok,
        iconStyle: IconStyle.error,
      );
      return;
    }

    Get.back();

    _isLoading.value = true;
    update();

    if (_tempModel.value.id == null) {
      // add project id
      _tempModel.value = _tempModel.value.copyWith(
        projectId: useController.project.id,
      );

      // create model
      await _projectModelServices.createProjectModel(
        model: _tempModel.value,
      );
    } else if (_tempModel.value.id != null) {
      // update model
      await _projectModelServices.updateProjectModel(
        model: _tempModel.value,
      );
    }

    await fetchApi();
    await resetTempModel();

    _isLoading.value = false;
    update();
  }

  // reset temp model
  resetTempModel() {
    _tempModel.value = ModelConfigModel();
    update();
  }

  // replace temp model
  replaceTempModel(ModelConfigModel model) {
    _tempModel.value = model;
    update();

    print({'🔥': _tempModel.value.id});
  }

  // delete model
  Future<void> deleteModel(String id) async {
    _isLoading.value = true;
    update();

    Get.back();
    resetTempModel();

    // get model by id
    ModelConfigModel activeModel = _models.firstWhere(
        (element) => element.id == id,
        orElse: () => ModelConfigModel());

    // get rest of the models
    List<ModelConfigModel> restModels =
        _models.where((element) => element.id != id).toList();

    for (var item in restModels) {
      item.relations?.where(
        (el) => el.name == activeModel.modelName,
      );

      // remove relation
      item.relations?.removeWhere(
        (el) => el.name == activeModel.modelName,
      );

      // remove properties
      item.properties?.removeWhere(
        (el) => el.relationName == activeModel.modelName,
      );

      // update rest models
      await _projectModelServices.updateProjectModel(model: item);
    }

    await _projectModelServices.deleteProjectModel(modelId: id);

    await fetchApi();

    _isLoading.value = false;
    update();
  }
}
