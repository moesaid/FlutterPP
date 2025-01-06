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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildProjectAvatar(
          icon: controller.project.icon ?? '',
          colors: [
            ColorHelper.hexToColor(controller.project.color1 ?? '#000000'),
            ColorHelper.hexToColor(controller.project.color2 ?? '#000000'),
          ],
        ),
        SizedBox(width: 6.spa),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  controller.project.title ?? '',
                  style: Get.textTheme.titleLarge,
                ),
                SizedBox(width: 2.spa),
                IconButton.filledTonal(
                  onPressed: () {
                    openEditProjectSheet(context);
                  },
                  style: ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    iconColor: WidgetStateProperty.all(
                      Get.theme.colorScheme.onPrimaryContainer,
                    ),
                    iconSize: WidgetStateProperty.all(5.spa),
                    backgroundColor: WidgetStateProperty.all(
                      Colors.transparent,
                    ),
                  ),
                  icon: const Icon(
                    Icons.settings,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.spa),
            SizedBox(
              width: context.width * 0.3,
              child: Text(
                controller.project.description ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Get.textTheme.bodySmall,
              ),
            ),
            SizedBox(height: 1.spa),
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
      builder: (localController) {
        return FormBuilder(
          key: formKey,
          initialValue: {
            'title': controller.project.title,
            'description': controller.project.description,
          },
          child: Padding(
            padding: EdgeInsets.all(8.0.spa),
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
                        onColorChange: (val) =>
                            localController.updateColors(val),
                        onSvgChange: (val) => localController.updateIcon(val),
                        hasCloseButton: false,
                        alignment: PossionAlignment.topBottom,
                      ),
                    );
                  },
                  child: BuildProjectAvatar(
                    colors: [
                      ColorHelper.hexToColor(
                          localController.activeColors.first),
                      ColorHelper.hexToColor(localController.activeColors.last),
                    ],
                    icon: localController.activeIcon,
                  ),
                ),
                SizedBox(height: 8.spa),
                FormBuilderTextField(
                  name: 'title',
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                SizedBox(height: 8.spa),
                FormBuilderTextField(
                  name: 'description',
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                const Spacer(),
                const Divider(),
                Container(
                  padding: EdgeInsets.only(top: 5.spa),
                  child: Row(
                    children: [
                      FilledButton(
                        onPressed: () async {
                          ProjectModel? item =
                              await localController.updateProject(
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
