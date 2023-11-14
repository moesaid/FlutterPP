import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_project_avatar.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:get/get.dart';

class BuildCreateMockupLinkProject extends StatelessWidget {
  final List<ProjectModel> projects;
  final void Function(ProjectModel) onProjectChange;

  const BuildCreateMockupLinkProject({
    super.key,
    required this.projects,
    required this.onProjectChange,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormBuilderChoiceChip(
            name: 'projects',
            spacing: 10,
            selectedColor: Get.theme.colorScheme.secondary,
            padding: const EdgeInsets.all(0),
            decoration: const InputDecoration(
              filled: false,
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
            onChanged: (val) => onProjectChange(val!),
            options: projects
                .map(
                  (e) => FormBuilderChipOption(
                    value: e,
                    avatar: BuildProjectAvatar(
                      colors: [
                        ColorHelper.hexToColor(e.color1!),
                        ColorHelper.hexToColor(e.color2!)
                      ],
                      icon: e.icon!,
                    ),
                    child: Text(e.title!),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
