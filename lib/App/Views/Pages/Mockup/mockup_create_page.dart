import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/mockup_create_controller.dart';
import 'package:flutterpp/App/Views/Global/build_close_button.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/build_create_mockup_choose_template.dart';
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
          appBar: AppBar(
            leading: const SizedBox.shrink(),
            actions: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: BuildCloseButton(),
              ),
            ],
          ),
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
                    steps: [
                      Step(
                        title: Text('mockup info'.capitalizeFirst!),
                        content: const BuildCreateMockupInfo(),
                      ),
                      Step(
                        title: Text('link to a project'.capitalizeFirst!),
                        content: const BuildCreateMockupLinkProject(),
                      ),
                      Step(
                        title: Text('choose a template'.capitalizeFirst!),
                        content: const BuildCreateMockupChooseTemplate(),
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
