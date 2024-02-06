import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_code_gen_controller.dart';
import 'package:get/get.dart';

class BuildCreateOrEditSheet extends StatelessWidget {
  const BuildCreateOrEditSheet({
    super.key,
    required this.controller,
  });

  final ProjectSingleCodeGenController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Text(controller.isLoading.toString()),
    );
  }
}
