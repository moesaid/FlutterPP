import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterpp/App/Controllers/Project/project_index_controller.dart';
import 'package:flutterpp/Config/app_gradients.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class ProjectIndexPage extends GetView<ProjectIndexController> {
  const ProjectIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProjectIndexController>(
        init: ProjectIndexController(),
        initState: (_) {},
        builder: (_) {
          return SafeArea(
            child: controller.isLoading
                ? const SizedBox()
                : controller.projects.isEmpty
                    ? BuildCreateProjectPage(
                        onColorChange: (val) => controller.onColorChange(val),
                        onSvgChange: (val) => controller.onSVGChange(val),
                        colors: controller.colors,
                        activeColors: controller.selectedColors,
                        activeSVG: controller.selectedSVG,
                        svgs: controller.svgs,
                      )
                    : Text(controller.projects.length.toString()),
          );
        },
      ),
    );
  }
}

class BuildCreateProjectPage extends StatelessWidget {
  final List<String> svgs;
  final String activeSVG;
  final List<Color> activeColors;
  final Function(List<Color>) onColorChange;
  final Function(String) onSvgChange;
  final List<List<Color>> colors;
  const BuildCreateProjectPage({
    Key? key,
    required this.onColorChange,
    required this.colors,
    required this.activeSVG,
    required this.activeColors,
    required this.svgs,
    required this.onSvgChange,
  }) : super(key: key);

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
                  Get.bottomSheet(
                    BuildIconAndGradients(
                      onColorChange: (val) => onColorChange.call(val),
                      onSvgChange: (val) => onSvgChange.call(val),
                      colors: colors,
                      svgs: svgs,
                    ),
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    gradient: AppGradients.getGradient(colors: activeColors),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: SvgPicture.asset(
                          'assets/svg/$activeSVG',
                          width: 22,
                          height: 22,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'title',
                decoration: const InputDecoration(
                  labelText: 'project Name',
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
                decoration: const InputDecoration(
                  labelText: 'Project Description',
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
                      // controller.createTeam(formKey.currentState!.value);
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

class BuildIconAndGradients extends StatelessWidget {
  final List<String> svgs;
  final List<List<Color>> colors;
  final Function(List<Color>) onColorChange;
  final Function(String) onSvgChange;
  const BuildIconAndGradients({
    Key? key,
    required this.onColorChange,
    required this.colors,
    required this.svgs,
    required this.onSvgChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Get.theme.bottomSheetTheme.backgroundColor,
        border: Border(
          top: BorderSide(
            color: Get.theme.scaffoldBackgroundColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          _BuildIconSection(
            svgs: svgs,
            onSvgChange: onSvgChange,
            colors: colors,
          ),
          const VerticalDivider(width: 0),
          _BuildColorsSection(colors: colors, onColorChange: onColorChange),
        ],
      ),
    );
  }
}

class _BuildColorsSection extends StatelessWidget {
  const _BuildColorsSection({
    Key? key,
    required this.colors,
    required this.onColorChange,
  }) : super(key: key);

  final List<List<Color>> colors;
  final Function(List<Color> p1) onColorChange;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${colors.length} Colors',
              style: Get.textTheme.headline6,
            ),
            const SizedBox(height: 5),
            const Text('Color us creative, yo.'),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: colors.length,
                shrinkWrap: true,
                itemBuilder: (_, int i) {
                  return GestureDetector(
                    onTap: () {
                      onColorChange.call(colors[i]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: AppGradients.getGradient(colors: colors[i]),
                      ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: colors.length ~/ (Get.width * 0.007),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildIconSection extends StatelessWidget {
  const _BuildIconSection({
    Key? key,
    required this.svgs,
    required this.onSvgChange,
    required this.colors,
  }) : super(key: key);

  final List<String> svgs;
  final Function(String p1) onSvgChange;
  final List<List<Color>> colors;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${svgs.length} Icons',
              style: Get.textTheme.headline6,
            ),
            const SizedBox(height: 5),
            const Text('Time to choose an icon, people!'),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: svgs.length,
                shrinkWrap: true,
                itemBuilder: (_, int i) {
                  return GestureDetector(
                    onTap: () {
                      onSvgChange.call(svgs[i]);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/svg/${svgs[i]}',
                          color: Colors.grey.withOpacity(0.5),
                          height: 22,
                          width: 22,
                        ),
                      ],
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: colors.length ~/ (Get.width * 0.007),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
