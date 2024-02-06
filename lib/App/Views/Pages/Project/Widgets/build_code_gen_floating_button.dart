import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_code_gen_controller.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_create_or_edit_sheet.dart';

class BuildCodeGenFloatingButton extends StatelessWidget {
  final BuildContext sharedContext;
  final ProjectSingleCodeGenController controller;
  final double sheetWidth;

  const BuildCodeGenFloatingButton(
      {super.key,
      required this.sharedContext,
      required this.controller,
      required this.sheetWidth});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FilledButton(
          onPressed: () => openCreateOrEditSheet(
            context: sharedContext,
            controller: controller,
            sheetWidth: sheetWidth,
          ),
          child: const Text('Create Model'),
        ),
      ],
    );
  }
}

// open create or edit model
void openCreateOrEditSheet({
  required BuildContext context,
  required double sheetWidth,
  required ProjectSingleCodeGenController controller,
}) {
  aweSideSheet(
    context: context,
    sheetPosition: SheetPosition.right,
    header: const SizedBox.shrink(),
    footer: const SizedBox.shrink(),
    sheetWidth: sheetWidth,
    body: BuildCreateOrEditSheet(controller: controller),
  );
}
