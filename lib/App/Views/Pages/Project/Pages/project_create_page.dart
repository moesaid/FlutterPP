import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Project/project_create_controller.dart';
import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Models/team_model.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_icon_and_gradients.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_project_avatar.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class ProjectCreatePage extends GetView<ProjectCreateController> {
  final List<String> svgs;
  final String activeSVG;
  final List<Color> activeColors;
  final Function(List<Color>) onColorChange;
  final Function(String) onSvgChange;
  final Function(ProjectModel) onCreateProject;
  final List<List<Color>> colors;
  final TeamModel team;

  const ProjectCreatePage({
    super.key,
    required this.onColorChange,
    required this.colors,
    required this.activeSVG,
    required this.activeColors,
    required this.svgs,
    required this.onSvgChange,
    required this.onCreateProject,
    required this.team,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return GetBuilder(
      init: ProjectCreateController(),
      didChangeDependencies: (state) {
        state.controller!.setUpController(team: team);
      },
      builder: (_) {
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
                          onColorChange: controller.onColorChange,
                          onSvgChange: controller.onSvgChange,
                          hasCloseButton: false,
                          alignment: PossionAlignment.topBottom,
                        ),
                      );
                    },
                    child: BuildProjectAvatar(
                      colors: controller.selectedColors,
                      icon: controller.selectedSVG,
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
                  const SizedBox(height: 15),
                  Text(
                    'State Management'.capitalize!,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // check box
                  FormBuilderChoiceChip(
                    name: 'stateManagement',
                    spacing: 10,
                    runSpacing: 10,
                    validator: FormBuilderValidators.required(),
                    initialValue: 'getx',
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      filled: false,
                    ),
                    options: const [
                      FormBuilderChipOption(
                        value: 'getx',
                        avatar: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image(
                            image: AssetImage('assets/images/getx_logo.png'),
                          ),
                        ),
                        child: Text('GetX'),
                      ),
                      FormBuilderChipOption(
                        value: 'bloc',
                        avatar: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image(
                            image: AssetImage('assets/images/bloc_logo.png'),
                          ),
                        ),
                        child: Text('Bloc'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  SizedBox(
                    width: Get.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.saveAndValidate()) {
                          controller.createProject(
                            formData: formKey.currentState!.value,
                            onCreateProject: onCreateProject,
                          );
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
      },
    );
  }
}
