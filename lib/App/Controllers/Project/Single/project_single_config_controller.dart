import 'package:flutterpp/App/Controllers/Project/Single/project_single_controller.dart';
import 'package:flutterpp/App/Services/Cmd/cmd_init_getx_mvc_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:get/get.dart';

class ProjectSingleConfigController extends GetxController {
  final CmdInitGetxMvcServices _cmd = CmdInitGetxMvcServices();
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
    await Get.showOverlay(
      asyncFunction: () async {
        await _cmd.init(useController.projectLocalPath);
        await useController.checkIfFlutterPPProject();
      },
      loadingWidget: const BuildOverlay(),
    );
  }
}
