import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Project/project_index_controller.dart';
import 'package:flutterpp/App/Controllers/Project/project_single_controller.dart';
import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Views/Global/build_sidebar.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_active_project_indecator.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_icon_and_gradients.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_project_avatar.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

class ProjectSinglePage extends GetView<ProjectSingleController> {
  const ProjectSinglePage({
    Key? key,
    required this.projectIndexController,
  }) : super(key: key);

  final ProjectIndexController projectIndexController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleController>(
      init: ProjectSingleController(),
      initState: (_) {},
      builder: (_) {
        return DefaultTabController(
          length: 10,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildSidebar(
                child: BuildProjectSidebar(
                  projectIndexController: projectIndexController,
                  controller: controller,
                ),
              ),
              Expanded(
                child: controller.tabs
                    .firstWhere((el) => el['isActive'] == true)['page'],
              )
            ],
          ),
        );
      },
    );
  }
}

class BuildProjectSidebar extends StatelessWidget {
  const BuildProjectSidebar({
    Key? key,
    required this.projectIndexController,
    required this.controller,
  }) : super(key: key);

  final ProjectIndexController projectIndexController;
  final ProjectSingleController controller;

  @override
  Widget build(BuildContext context) {
    final ProjectModel activeProject = projectIndexController.activeProject;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildActiveProjectIndecator(
            activeProject: activeProject,
            projectIndexController: projectIndexController,
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.separated(
              itemCount: controller.tabs.length,
              padding: const EdgeInsets.all(5),
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemBuilder: (_, int index) {
                final Map<String, dynamic> tab = controller.tabs[index];
                return InkWell(
                  onTap: () => controller.updateTabs(index),
                  child: SizedBox(
                    // color: Colors.red,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        HeroIcon(
                          tab['icon'],
                          size: 16,
                          color: index == controller.selectedTab
                              ? Get.theme.colorScheme.secondary.withOpacity(0.6)
                              : Get.theme.backgroundColor.withOpacity(0.5),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          tab['title'].toString().capitalize!,
                          style: TextStyle(
                            height: 1,
                            color: index == controller.selectedTab
                                ? Get.theme.colorScheme.secondary
                                : Get.theme.backgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.bottomSheet(
                BuildCreateProjectDialog(
                  projectIndexController: projectIndexController,
                ),
                isScrollControlled: true,
              ),
              child: Text(
                'create new project'.capitalize!,
                style: Get.textTheme.bodyMedium,
              ),
            ),
          ),
          const SizedBox(height: 6)
        ],
      ),
    );
  }
}

class BuildCreateProjectDialog extends StatelessWidget {
  const BuildCreateProjectDialog({
    Key? key,
    required this.projectIndexController,
  }) : super(key: key);

  final ProjectIndexController projectIndexController;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return Container(
      margin: const EdgeInsets.only(top: 100),
      color: Get.theme.colorScheme.surface,
      child: Stack(
        fit: StackFit.loose,
        children: [
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: const HeroIcon(HeroIcons.xMark),
            ),
          ),
          FormBuilder(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<ProjectIndexController>(
                    init: ProjectIndexController(),
                    initState: (_) {},
                    builder: (_) {
                      return GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            BuildIconAndGradients(
                              onColorChange: (val) {
                                _.onColorChange(val);
                              },
                              onSvgChange: (val) {
                                _.onSVGChange(val);
                              },
                              colors: _.colors,
                              svgs: _.svgs,
                            ),
                          );
                        },
                        child: BuildProjectAvatar(
                          colors: _.selectedColors,
                          icon: _.selectedSVG,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 400,
                    child: FormBuilderTextField(
                      name: 'title',
                      decoration: InputDecoration(
                        labelText: 'project title'.capitalize,
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(3),
                        FormBuilderValidators.maxLength(20),
                      ]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 400,
                    child: FormBuilderTextField(
                      name: 'description',
                      decoration: InputDecoration(
                        labelText: 'Project Description'.capitalize,
                      ),
                      minLines: 3,
                      maxLines: 5,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(10),
                        FormBuilderValidators.maxLength(90),
                      ]),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 400,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.saveAndValidate()) {
                          await projectIndexController.createProject(
                            formData: formKey.currentState!.value,
                          );
                        }

                        Get.back();
                      },
                      child: const Text('Create project'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
