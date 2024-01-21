import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_icon_and_gradients.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_project_avatar.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class ProjectCreatePage extends StatelessWidget {
  final List<String> svgs;
  final String activeSVG;
  final List<Color> activeColors;
  final Function(List<Color>) onColorChange;
  final Function(String) onSvgChange;
  final Function(Map) createProject;
  final List<List<Color>> colors;
  const ProjectCreatePage({
    super.key,
    required this.onColorChange,
    required this.colors,
    required this.activeSVG,
    required this.activeColors,
    required this.svgs,
    required this.onSvgChange,
    required this.createProject,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formKey,
      child: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  aweSideSheet(
                    context: context,
                    sheetPosition: SheetPosition.right,
                    header: const SizedBox.shrink(),
                    footer: const SizedBox.shrink(),
                    body: BuildIconAndGradients(
                      onColorChange: (val) => onColorChange.call(val),
                      onSvgChange: (val) => onSvgChange.call(val),
                      hasCloseButton: false,
                      alignment: PossionAlignment.topBottom,
                    ),
                  );
                },
                child: BuildProjectAvatar(
                  colors: activeColors,
                  icon: activeSVG,
                ),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
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
              const SizedBox(height: 10),
              FormBuilderTextField(
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
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              SizedBox(
                width: Get.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.saveAndValidate()) {
                      createProject.call(formKey.currentState!.value);
                    }
                  },
                  child: const Text('Create project'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
