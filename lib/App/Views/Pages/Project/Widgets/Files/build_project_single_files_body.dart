import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_files_controller.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:flutterpp/App/Views/Pages/Project/InnerPages/project_single_files_page.dart';
import 'package:get/get.dart';

class BuildProjectSingleFilesBody extends StatelessWidget {
  const BuildProjectSingleFilesBody({
    super.key,
    required this.controller,
  });

  final ProjectSingleFilesController controller;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: Column(
        children: [
          BuildProjectSingleFilesHeader(controller: controller),
          Expanded(
            child: BuildLoadingOrEmptyLayout(
              isLoading: controller.isLoading,
              isEmpty: controller.files.isEmpty,
              title: 'No Files Found'.capitalize!,
              child: BuildProjectSingleFilesList(
                controller: controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
