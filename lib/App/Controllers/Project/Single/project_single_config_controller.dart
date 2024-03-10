import 'package:flutterpp/App/Controllers/Project/Single/project_single_controller.dart';
import 'package:flutterpp/App/Enums/state_manegment_enum.dart';
import 'package:flutterpp/App/Services/Cmd/cmd_init_bloc_services.dart';
import 'package:flutterpp/App/Services/Cmd/cmd_init_getx_mvc_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:flutterpp/Config/app_print.dart';
import 'package:get/get.dart';

class ProjectSingleConfigController extends GetxController {
  final CmdInitGetxMvcServices _getxCmd = CmdInitGetxMvcServices();
  final CmdInitBlocServices _blocCmd = CmdInitBlocServices();
  late ProjectSingleController useController;

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  @override
  Future<void> onInit() async {
    await _findControllers();

    super.onInit();
  }

  // find controllers
  Future<void> _findControllers() async {
    if (Get.isRegistered<ProjectSingleController>()) {
      useController = Get.find<ProjectSingleController>();
    }
  }

  Future<void> startConfig() async {
    if (useController.projectLocalPath.isEmpty) return;

    try {
      await Get.showOverlay(
        asyncFunction: () async {
          // getx
          if (useController.project.stateManagement ==
              StateManegmentEnum.getx.name) {
            await _getxCmd.init(useController.projectLocalPath);
          }

          // bloc
          if (useController.project.stateManagement ==
              StateManegmentEnum.bloc.name) {
            await _blocCmd.init(useController.projectLocalPath);
          }

          await useController.checkIfFlutterPPProject();
        },
        loadingWidget: const BuildOverlay(),
      );
    } catch (e) {
      AppPrint.printError('Error starting project config: $e');
    }
  }
}
