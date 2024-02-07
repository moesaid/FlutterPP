import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_code_gen_controller.dart';
import 'package:flutterpp/App/Models/build_option_model.dart';
import 'package:flutterpp/App/Views/Global/buiuld_dialog.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_create_or_edit_sheet.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildCodeGenFloatingButton extends StatelessWidget {
  final BuildContext sharedContext;
  final ProjectSingleCodeGenController controller;
  final double sheetWidth;

  const BuildCodeGenFloatingButton({
    super.key,
    required this.sharedContext,
    required this.controller,
    required this.sheetWidth,
  });

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
          style: FilledButton.styleFrom(
            textStyle: const TextStyle(letterSpacing: 0),
          ),
          child: Text('Create new Model'.capitalize!),
        ),
        SizedBox(width: 4.sp),
        FilledButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => BuildCodeGenBuildOption(
              onBuild: controller.generateCode,
            ),
          ),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.black.withOpacity(0.5),
          ),
          child: Badge.count(
            count: controller.diffCount,
            alignment: Alignment.topRight,
            offset: const Offset(20, -10),
            child: Text('generate'.capitalize!),
          ),
        ),
      ],
    );
  }
}

class BuildCodeGenBuildOption extends StatelessWidget {
  final Future<void> Function(BuildOptionModel option) onBuild;
  const BuildCodeGenBuildOption({
    super.key,
    required this.onBuild,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return BuildDefultDialog(
      height: context.height * 0.7,
      child: FormBuilder(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Build options'.capitalize!,
              style: Get.theme.textTheme.titleLarge,
            ),
            Divider(height: 16.sp),
            FormBuilderSwitch(
              name: 'models',
              initialValue: true,
              title: const Text('Models'),
              activeColor: Get.theme.colorScheme.secondary,
              activeTrackColor:
                  Get.theme.colorScheme.secondary.withOpacity(0.3),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
              ),
            ),
            SizedBox(height: 2.sp),
            FormBuilderSwitch(
              name: 'pages',
              initialValue: false,
              activeColor: Get.theme.colorScheme.secondary,
              activeTrackColor:
                  Get.theme.colorScheme.secondary.withOpacity(0.3),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pages'),
                  SizedBox(height: 2.sp),
                  Text(
                    'Note: This will generate pages for all the models \nand overwriting the existing pages'
                        .capitalize!,
                    style: Get.theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.sp),
            FormBuilderSwitch(
              name: 'routes',
              initialValue: false,
              activeColor: Get.theme.colorScheme.secondary,
              activeTrackColor:
                  Get.theme.colorScheme.secondary.withOpacity(0.3),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Routes'),
                  SizedBox(height: 2.sp),
                  Text(
                    'Routes are always appended to the existing routes.'
                        .capitalize!,
                    style: Get.theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.sp),
            FormBuilderSwitch(
              name: 'controllers',
              initialValue: false,
              activeColor: Get.theme.colorScheme.secondary,
              activeTrackColor:
                  Get.theme.colorScheme.secondary.withOpacity(0.3),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
              ),
              title: const Text('Controllers'),
            ),
            SizedBox(height: 2.sp),
            FormBuilderSwitch(
              name: 'bindings',
              initialValue: false,
              activeColor: Get.theme.colorScheme.secondary,
              activeTrackColor:
                  Get.theme.colorScheme.secondary.withOpacity(0.3),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Bindings'),
                      SizedBox(width: 2.sp),
                      Text(
                        '(recommended when adding controllers)',
                        style: TextStyle(
                          color: Get.theme.colorScheme.secondary,
                          fontSize: 4.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.sp),
                  Text(
                    'bindings are always appended to the existing bindings'
                        .capitalize!,
                    style: Get.theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.sp),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () async {
                      formKey.currentState?.save();

                      BuildOptionModel buildOptionModel = BuildOptionModel(
                        models: formKey.currentState?.value['models'],
                        pages: formKey.currentState?.value['pages'],
                        routes: formKey.currentState?.value['routes'],
                        controllers: formKey.currentState?.value['controllers'],
                        bindings: formKey.currentState?.value['bindings'],
                      );

                      Get.back();
                      await onBuild.call(buildOptionModel);
                    },
                    child: Text('Build'.capitalize!),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
