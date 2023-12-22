import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/mockup_create_controller.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/build_create_mockup_choose_template.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/build_create_mockup_info.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/build_create_mockup_link_project.dart';
import 'package:get/get.dart';

class MockupCreatePage extends GetView<MockupCreateController> {
  const MockupCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MockupCreateController>(
      init: MockupCreateController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: GetBuilder<MockupCreateController>(
            init: MockupCreateController(),
            initState: (_) {},
            builder: (_) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Stepper(
                    type: StepperType.vertical,
                    currentStep: controller.currentStep,
                    onStepContinue: () => controller.onStepContinue(),
                    onStepCancel: () => controller.onStepCancel(),
                    controlsBuilder: (context, details) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            if (controller.currentStep != 0)
                              ElevatedButton(
                                onPressed: () => controller.onStepCancel(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.withOpacity(0.1),
                                ),
                                child: const Text('back'),
                              ),
                            const SizedBox(width: 10),
                            if (controller.currentStep != 2)
                              ElevatedButton(
                                onPressed: () => controller.onStepContinue(),
                                child: const Text('next'),
                              ),
                            if (controller.currentStep == 2)
                              ElevatedButton(
                                onPressed: () => controller.onStepContinue(),
                                child: const Text('finish'),
                              ),
                          ],
                        ),
                      );
                    },
                    steps: [
                      Step(
                        title: Text('mockup info'.capitalizeFirst!),
                        content: BuildCreateMockupInfo(
                          onTitleOrDescriptionOrCategory:
                              controller.onTitleOrDescriptionOrCategory,
                          onColorChange: controller.onGradientChange,
                          onSvgChange: controller.onIconChange,
                          activeColors: controller.activeGradient,
                          activeSVG: controller.activeIcon,
                          title: controller.title,
                          description: controller.description,
                          category: controller.category,
                        ),
                      ),
                      Step(
                        title: BuildCreateMockupLinkProjectTitle(
                          controller: controller,
                        ),
                        content: BuildCreateMockupLinkProject(
                          projects: controller.projects,
                          onProjectChange: controller.onProjectChange,
                        ),
                      ),
                      Step(
                        title: Text('choose a template'.capitalizeFirst!),
                        content: BuildCreateMockupChooseTemplate(
                          onTemplateChange: controller.onTemplateChange,
                          templateId: controller.templateId,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class BuildCreateMockupLinkProjectTitle extends StatelessWidget {
  const BuildCreateMockupLinkProjectTitle({
    super.key,
    required this.controller,
  });

  final MockupCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('link to a project'.capitalizeFirst!),
        const SizedBox(width: 10),
        if (controller.projects.isEmpty)
          const Text(
            'no projects found 😢',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        if (controller.projects.isNotEmpty)
          Text(
            'found ${controller.projects.length} projects',
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
      ],
    );
  }
}
