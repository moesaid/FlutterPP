import 'package:flutterpp/App/Controllers/Global/build_api_gen_node_controller.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_api_gen_controller.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_board_controller.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_code_gen_controller.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_config_controller.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_controller.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_edit_controller.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_files_controller.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_wiki_controller.dart';
import 'package:flutterpp/App/Controllers/Project/project_create_controller.dart';
import 'package:get/get.dart';

class AppProjectBinding {
  // int
  static int() {
    Get.lazyPut<ProjectSingleController>(() => ProjectSingleController());
    Get.lazyPut<ProjectSingleWikiController>(
        () => ProjectSingleWikiController());
    Get.lazyPut<ProjectSingleBoardController>(
        () => ProjectSingleBoardController());
    Get.lazyPut<ProjectSingleConfigController>(
        () => ProjectSingleConfigController());
    Get.lazyPut<ProjectSingleCodeGenController>(
        () => ProjectSingleCodeGenController());

    Get.lazyPut<ProjectSingleEditController>(
        () => ProjectSingleEditController());

    Get.lazyPut<ProjectSingleFilesController>(
        () => ProjectSingleFilesController());

    Get.lazyPut<ProjectSingleApiGenController>(
        () => ProjectSingleApiGenController());

    Get.lazyPut<BuildApiGenNodeController>(() => BuildApiGenNodeController());

    Get.lazyPut<ProjectCreateController>(() => ProjectCreateController());
  }
}
