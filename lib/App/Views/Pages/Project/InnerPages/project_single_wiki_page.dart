// import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_wiki_controller.dart';
import 'package:get/get.dart' hide Node;
import 'package:get/get.dart';

class ProjectSingleWikiPage extends GetView<ProjectSingleWikiController> {
  const ProjectSingleWikiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleWikiController>(
      init: ProjectSingleWikiController(),
      initState: (_) {},
      builder: (_) {
        return const Scaffold(
          body: SafeArea(
            child: Text('ProjetSingleWikiController'),
          ),
        );
      },
    );
  }
}
