import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_controller.dart';
import 'package:flutterpp/App/Models/build_option_model.dart';
import 'package:flutterpp/App/Models/model_config_model.dart';
import 'package:flutterpp/App/Providers/Cmd/cmd_flutter_provider.dart';
import 'package:flutterpp/App/Providers/FilesGen/Json/json_to_freezed_class_provider.dart';
import 'package:flutterpp/App/Providers/FilesGen/build_runner_provider.dart';
import 'package:flutterpp/App/Services/Cmd/cmd_init_getx_mvc_services.dart';
import 'package:flutterpp/App/Services/Cmd/cmd_read_create_dir_services.dart';
import 'package:flutterpp/App/Services/Project/project_model_services.dart';
import 'package:flutterpp/App/Views/Global/build_time_overlay.dart';
import 'package:flutterpp/Config/app_print.dart';
import 'package:get/get.dart';
import 'package:graphite/graphite.dart';

class ProjectSingleCodeGenController extends GetxController {
  late ProjectSingleController useController;

  final ProjectModelServices _projectModelServices = ProjectModelServices();
  final CmdReadCreateDirServices _cmdReadCreateDirServices =
      CmdReadCreateDirServices();
  final CmdInitGetxMvcServices _cmdInitGetxMvcServices =
      CmdInitGetxMvcServices();

  final JsonToFreezedClassProvider _jsonToFreezedClassProvider =
      JsonToFreezedClassProvider();
  final CmdFlutterProvider _cmdF = CmdFlutterProvider();

  final BuildRunnerProvider _cmdBuild = BuildRunnerProvider();

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _canGenerate = false.obs;
  bool get canGenerate => _canGenerate.value;

  final _diffCount = 0.obs;
  int get diffCount => _diffCount.value;

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
    AppPrint.print('❌fetching api: ${useController.project.id}');
    List<ModelConfigModel>? res = await _projectModelServices.getProjectById(
      projectId: useController.project.id,
    );

    AppPrint.print('❌res: $res');

    // check if res is null
    if (res == null) return;

    _nodes.clear();
    _models.assignAll(res);
    for (var item in _models) {
      List<EdgeInput> nextItems = [];

      if (item.relations != null && item.relations!.isNotEmpty) {
        if (item.relations == null || item.relations!.isEmpty) continue;

        for (var relation in item.relations!) {
          // get relation model id
          String? relationModelId = _models
              .firstWhereOrNull((el) => el.modelName == relation.name)
              ?.id;

          if (relationModelId == null) continue;

          nextItems.add(EdgeInput(outcome: relationModelId));
        }
      }

      // add to nodes
      _nodes.add(NodeInput(id: item.id!, next: nextItems));
    }

    update();

    await checkModelDiff();
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

    // if name already exists
    if (_models.any((el) => el.modelName == _tempModel.value.modelName)) {
      FlutterPlatformAlert.playAlertSound();
      FlutterPlatformAlert.showAlert(
        windowTitle: 'Oops!',
        text: 'Model name already exists!',
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

  // check model diff
  checkModelDiff() async {
    List<String>? res = await _cmdReadCreateDirServices.readDirectory(
      '${useController.projectLocalPath}/lib/App/Models',
    );

    if (res == null) return;

    _diffCount.value = (_models.length - res.length).isNegative
        ? 0
        : _models.length - res.length;
    _canGenerate.value = _diffCount.value.isGreaterThan(0);
    update();
  }

  // generate code
  Future<void> generateCode(BuildOptionModel option) async {
    FlutterPlatformAlert.playAlertSound();
    CustomButton res = await FlutterPlatformAlert.showCustomAlert(
      windowTitle: 'note!'.toUpperCase(),
      text: 'make sure you can roolback the changes if something goes wrong.',
      positiveButtonTitle: 'continue with caution!',
      negativeButtonTitle: 'cancel',
    );

    if (res == CustomButton.negativeButton) return;

    Get.showOverlay(
      asyncFunction: () async {
        for (var item in _models) {
          if (option.models == true) {
            await _jsonToFreezedClassProvider.generateFreezedClass(
              useController.projectLocalPath,
              item,
            );
          }

          await _cmdInitGetxMvcServices.createCase(
            useController.projectLocalPath,
            item.modelName!,
            isCrud: item.isCrud,
            option: option,
          );
        }

        // run build runner
        await _cmdBuild.createBuildYaml(useController.projectLocalPath);
        await _cmdF.runDartCommand(useController.projectLocalPath,
            ['run', 'build_runner', 'build', '--delete-conflicting-outputs']);

        await checkModelDiff();
      },
      loadingWidget: const BuildTimeOverlay(),
    );
  }
}
