// import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/project_single_board_controller.dart';
import 'package:get/get.dart';

class ProjectSingleBoardPage extends GetView<ProjectSingleBoardController> {
  const ProjectSingleBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleBoardController>(
      init: ProjectSingleBoardController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
            appBar: AppBar(title: const Text('ProjectSingleBoardPage')),
            body: const SafeArea(child: Text('ProjectSingleBoardController')));
      },
    );
  }
}
