import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/project_index_controller.dart';
import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_project_avatar.dart';
import 'package:flutterpp/Helpers/helper_colors.dart';
import 'package:heroicons/heroicons.dart';
import 'package:get/get.dart';

class BuildActiveProjectIndecator extends StatelessWidget {
  const BuildActiveProjectIndecator({
    Key? key,
    required this.activeProject,
    required this.projectIndexController,
  }) : super(key: key);

  final ProjectModel activeProject;
  final ProjectIndexController projectIndexController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.defaultDialog(
        title: 'Project pick time!',
        titlePadding: const EdgeInsets.only(top: 15),
        contentPadding: const EdgeInsets.all(15),
        titleStyle: Get.textTheme.bodyMedium,
        backgroundColor: Get.theme.dialogBackgroundColor,
        radius: 8,
        content: _BuildDialog(
          activeProject: activeProject,
          projectIndexController: projectIndexController,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Get.theme.dividerColor.withOpacity(0.01),
          border: Border.all(
            color: Get.theme.dividerColor.withOpacity(0.05),
          ),
        ),
        child: Row(
          children: [
            BuildProjectAvatar(
              height: 30,
              width: 30,
              svgWidth: 15,
              svgHeight: 15,
              colors: [
                ColorHelper.hexToColor(activeProject.color1!),
                ColorHelper.hexToColor(activeProject.color2!),
              ],
              icon: activeProject.icon!,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                projectIndexController.activeProject.title!.length > 15
                    ? '${projectIndexController.activeProject.title!.substring(0, 15)}...'
                    : projectIndexController.activeProject.title!,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 12,
                  height: 0.8,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Column(
              children: [
                HeroIcon(
                  HeroIcons.chevronUp,
                  size: 10,
                  color: Get.theme.dividerColor.withOpacity(0.5),
                ),
                HeroIcon(
                  HeroIcons.chevronDown,
                  size: 10,
                  color: Get.theme.dividerColor.withOpacity(0.5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildDialog extends StatelessWidget {
  final ProjectModel activeProject;
  final ProjectIndexController projectIndexController;
  const _BuildDialog({
    Key? key,
    required this.activeProject,
    required this.projectIndexController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ProjectModel> projects = projectIndexController.projects;

    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          width: 600,
          child: GridView.builder(
            itemBuilder: (_, int index) {
              ProjectModel project = projects[index];
              return InkWell(
                onTap: () {
                  projectIndexController.onProjectChange(project);
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: activeProject.id == project.id
                        ? Get.theme.colorScheme.primary.withOpacity(0.1)
                        : Get.theme.backgroundColor.withOpacity(0.1),
                    border: Border.all(
                      color: activeProject.id == project.id
                          ? Get.theme.colorScheme.secondary
                          : Get.theme.dividerColor.withOpacity(0.1),
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: activeProject.id == project.id
                            ? Get.theme.colorScheme.secondary
                            : Get.theme.backgroundColor.withOpacity(0.3),
                        radius: 6,
                      ),
                      const SizedBox(width: 8),
                      BuildProjectAvatar(
                        colors: [
                          ColorHelper.hexToColor(project.color1!),
                          ColorHelper.hexToColor(project.color2!),
                        ],
                        icon: project.icon!,
                        height: 34,
                        width: 34,
                        svgWidth: 15,
                        svgHeight: 15,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        project.title!.length > 15
                            ? '${project.title!.substring(0, 15)}...'
                            : project.title!,
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: projects.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 50,
            ),
          ),
        ),
      ],
    );
  }
}
