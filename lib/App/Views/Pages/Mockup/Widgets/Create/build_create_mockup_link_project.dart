import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_project_avatar.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
            spacing: 3.sp,
            runSpacing: 3.sp,
            shape: ContinuousRectangleBorder(
              side: BorderSide(
                color: Get.theme.colorScheme.secondaryContainer,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            selectedColor: Get.theme.colorScheme.secondary,
            padding: const EdgeInsets.symmetric(vertical: 2),
            labelPadding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: const InputDecoration(
              filled: false,
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
            onChanged: (val) => onProjectChange(val ?? projects.first),
            options: projects
                .map(
                  (e) => FormBuilderChipOption(
                    value: e,
                    avatar: Padding(
                      padding: const EdgeInsets.all(3),
                      child: BuildProjectAvatar(
                        height: 10.sp,
                        colors: [
                          ColorHelper.hexToColor(e.color1!),
                          ColorHelper.hexToColor(e.color2!)
                        ],
                        icon: e.icon!,
                        svgHeight: 5.sp,
                        svgWidth: 5.sp,
                      ),
                    ),
                    child: Text(
                      e.title!.capitalize!,
                      style: Get.textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 20.sp),
        ],
      ),
    );
  }
}
