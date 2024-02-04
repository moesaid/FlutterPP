import 'dart:convert';
import 'dart:io';

import 'package:flutterpp/App/Controllers/Project/Single/project_single_controller.dart';
import 'package:flutterpp/App/Models/model_config_model.dart';
import 'package:flutterpp/App/Providers/Cmd/cmd_flutter_provider.dart';
import 'package:flutterpp/App/Providers/FilesGen/Json/json_to_freezed_class_provider.dart';
import 'package:flutterpp/App/Services/Cmd/cmd_init_getx_mvc_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:get/get.dart';

class ProjectSingleConfigController extends GetxController {
  final CmdInitGetxMvcServices _cmd = CmdInitGetxMvcServices();

  late ProjectSingleController useController;

  @override
  void onInit() {
    _findControllers();
    super.onInit();
  }

  // find controllers
  void _findControllers() {
    if (Get.isRegistered<ProjectSingleController>()) {
      useController = Get.find<ProjectSingleController>();
    }
  }

  Future<void> startConfig() async {
    if (useController.projectLocalPath.isEmpty) return;
    await Get.showOverlay(
      asyncFunction: () async {
        // await _cmd.init(useController.projectLocalPath);
        // await _cmd.createCase(
        //   useController.projectLocalPath,
        //   'profile',
        //   isCrud: true,
        // );

        // load local json file
        const String path =
            '/Users/mohamedsaid/Development/flutter_workshop/Apps/flutterpp/lib/App/Providers/FilesGen/Json/test.json';

        // Read the file
        final File file = File(path);
        final String jsonString = file.readAsStringSync();

        // Parse the JSON
        List jsonData = jsonDecode(jsonString);

        for (var item in jsonData) {
          // ModelConfigModel modelConfig = ModelConfigModel.fromJson(item);

          await JsonToFreezedClassProvider().generateFreezedClass(
            useController.projectLocalPath,
            ModelConfigModel.fromJson(item),
          );
        }

        // await JsonToFreezedClassProvider().generateFreezedClass(
        //   useController.projectLocalPath,
        //   ModelConfigModel(
        //     modelName: 'user',
        //     properties: [
        //       Properties(name: 'id', type: PropertieType.int),
        //       Properties(name: 'age', type: PropertieType.double),
        //       Properties(name: 'name', type: PropertieType.string),
        //       Properties(name: 'isOnline', type: PropertieType.bool),
        //       Properties(
        //         name: 'profile',
        //         type: PropertieType.hasOne,
        //         relationName: 'profile',
        //       ),
        //       Properties(
        //         name: 'cars',
        //         type: PropertieType.hasMany,
        //         relationName: 'car',
        //       ),
        //     ],
        //     relations: [
        //       Relations(name: 'profile'),
        //       Relations(name: 'car'),
        //     ],
        //   ),
        // );

        // await JsonToFreezedClassProvider().generateFreezedClass(
        //   useController.projectLocalPath,
        //   ModelConfigModel(modelName: 'profile', properties: [
        //     Properties(name: 'id', type: PropertieType.int),
        //     Properties(name: 'age', type: PropertieType.double),
        //     Properties(name: 'name', type: PropertieType.string),
        //     Properties(name: 'isOnline', type: PropertieType.bool),
        //   ]),
        // );
        // await JsonToFreezedClassProvider().generateFreezedClass(
        //   useController.projectLocalPath,
        //   ModelConfigModel(modelName: 'car', properties: [
        //     Properties(name: 'id', type: PropertieType.int),
        //     Properties(name: 'type', type: PropertieType.string),
        //     Properties(name: 'color', type: PropertieType.string),
        //     Properties(name: 'isActive', type: PropertieType.bool),
        //   ]),
        // );

        // run build runner
        await CmdFlutterProvider().runDartCommand(
          useController.projectLocalPath,
          ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
        );

        // // run fix
        // await CmdFlutterProvider().runDartCommand(
        //   useController.projectLocalPath,
        //   ['fix', '--apply'],
        // );

        // // format
        // await CmdFlutterProvider().runDartCommand(
        //   useController.projectLocalPath,
        //   ['format', '.'],
        // );
      },
      loadingWidget: const BuildOverlay(),
    );
  }
}
