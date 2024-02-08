import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_controller.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_edit_controller.dart';
import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_icon_and_gradients.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_project_avatar.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildSingleProjectHeadInfo extends StatelessWidget {
  const BuildSingleProjectHeadInfo({
    super.key,
    required this.controller,
  });

  final ProjectSingleController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BuildProjectAvatar(
          icon: controller.project.icon ?? '',
          colors: [
            ColorHelper.hexToColor(controller.project.color1 ?? '#000000'),
            ColorHelper.hexToColor(controller.project.color2 ?? '#000000'),
          ],
        ),
        SizedBox(width: 6.sp),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  controller.project.title ?? '',
                  style: Get.textTheme.titleLarge,
                ),
                SizedBox(width: 2.sp),
                IconButton.filledTonal(
                  onPressed: () {
                    openEditProjectSheet(context);
                  },
                  style: ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    iconColor: MaterialStateProperty.all(
                      Get.theme.colorScheme.onPrimaryContainer,
                    ),
                    iconSize: MaterialStateProperty.all(5.sp),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.transparent,
                    ),
                  ),
                  icon: const Icon(
                    Icons.settings,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.sp),
            Text(
              controller.project.description ?? '',
              style: Get.textTheme.bodyMedium,
            ),
            SizedBox(height: 1.sp),
          ],
        ),
      ],
    );
  }

  Future<void> openEditProjectSheet(BuildContext context) {
    return aweSideSheet(
      context: context,
      title: 'edit project',
      sheetWidth: context.width * 0.4,
      sheetPosition: SheetPosition.right,
      body: BuildEditProject(controller: controller),
      footer: const SizedBox.shrink(),
    );
  }
}

class BuildEditProject extends StatelessWidget {
  const BuildEditProject({
    super.key,
    required this.controller,
  });

  final ProjectSingleController controller;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return GetBuilder<ProjectSingleEditController>(
      init: ProjectSingleEditController(),
      didChangeDependencies: (state) {
        state.controller?.updateColors(
          [
            ColorHelper.hexToColor(controller.project.color1 ?? '#000000'),
            ColorHelper.hexToColor(controller.project.color2 ?? '#000000'),
          ],
        );

        state.controller?.updateIcon(controller.project.icon ?? '');
      },
      initState: (_) {},
      builder: (_) {
        return FormBuilder(
          key: formKey,
          initialValue: {
            'title': controller.project.title,
            'description': controller.project.description,
          },
          child: Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    aweSideSheet(
                      context: context,
                      sheetPosition: SheetPosition.right,
                      header: const SizedBox.shrink(),
                      footer: const SizedBox.shrink(),
                      body: BuildIconAndGradients(
                        onColorChange: (val) => _.updateColors(val),
                        onSvgChange: (val) => _.updateIcon(val),
                        hasCloseButton: false,
                        alignment: PossionAlignment.topBottom,
                      ),
                    );
                  },
                  child: BuildProjectAvatar(
                    colors: [
                      ColorHelper.hexToColor(_.activeColors.first),
                      ColorHelper.hexToColor(_.activeColors.last),
                    ],
                    icon: _.activeIcon,
                  ),
                ),
                SizedBox(height: 8.sp),
                FormBuilderTextField(
                  name: 'title',
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                SizedBox(height: 8.sp),
                FormBuilderTextField(
                  name: 'description',
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                const Spacer(),
                const Divider(),
                Container(
                  padding: EdgeInsets.only(top: 5.sp),
                  child: Row(
                    children: [
                      FilledButton(
                        onPressed: () async {
                          ProjectModel? item = await _.updateProject(
                            project: controller.project.copyWith(
                              title:
                                  formKey.currentState?.fields['title']?.value,
                              description: formKey
                                  .currentState?.fields['description']?.value,
                            ),
                          );

                          if (item != null) {
                            controller.updateProject(item);
                          }

                          Get.back();
                        },
                        child: const Text('Save and update'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
