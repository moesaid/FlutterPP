import 'package:flutterpp/App/Controllers/Project/project_single_board_controller.dart';
import 'package:flutterpp/App/Controllers/Project/project_single_generator_controller.dart';
import 'package:flutterpp/App/Controllers/Project/project_single_wiki_controller.dart';
import 'package:get/get.dart';

class AppProjectBinding {
  // int
  static int() {
    Get.lazyPut<ProjectSingleWikiController>(
      () => ProjectSingleWikiController(),
    );
    Get.lazyPut<ProjectSingleBoardController>(
      () => ProjectSingleBoardController(),
    );

    Get.lazyPut<ProjectSingleGeneratorController>(
      () => ProjectSingleGeneratorController(),
    );
  }

  // remove
  static close() {
    Get.delete<ProjectSingleWikiController>();
    Get.delete<ProjectSingleBoardController>();
    Get.delete<ProjectSingleGeneratorController>();
  }
}
