import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Team/no_team_controller.dart';
import 'package:flutterpp/App/Views/Global/build_page_layout.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NoTeamPage extends GetView<NoTeamController> {
  const NoTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoTeamController>(
      init: NoTeamController(),
      initState: (_) {},
      builder: (_) {
        return BuildPageLayout(
          child: Center(
            child: SizedBox(
              width: 400,
              height: 400,
              child: DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'kick off your journey with Flutter++ !',
                      style: Get.theme.textTheme.bodyLarge,
                    ),
                    SizedBox(height: 1.spa),
                    Text(
                      'by creating a team or joining one !',
                      style: Get.theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 60),
                    const _BuildTabs(),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _BuildCreateTeamForm(controller: controller),
                          _BuildJoinTeamForm(controller: controller),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BuildJoinTeamForm extends StatelessWidget {
  final NoTeamController controller;
  const _BuildJoinTeamForm({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // autoFocusOnValidationFailure: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FormBuilderTextField(
            name: 'code',
            decoration: const InputDecoration(
              labelText: 'invite code',
            ),
            maxLength: 6,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(6),
              FormBuilderValidators.maxLength(6),
            ]),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: Get.width,
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.saveAndValidate()) {
                  controller.joinTeam(formKey.currentState!.value);
                }
              },
              child: const Text('Join a Team'),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildCreateTeamForm extends StatelessWidget {
  final NoTeamController controller;
  const _BuildCreateTeamForm({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FormBuilderTextField(
            name: 'name',
            decoration: const InputDecoration(
              labelText: 'Team Name',
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
              labelText: 'Team Description',
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
          SizedBox(
            width: Get.width,
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.saveAndValidate()) {
                  controller.createTeam(formKey.currentState!.value);
                }
              },
              child: const Text('Create Team'),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildTabs extends StatelessWidget {
  const _BuildTabs();

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 2,
          color: Get.theme.colorScheme.secondary,
        ),
      ),
      indicatorWeight: 0,
      automaticIndicatorColorAdjustment: true,
      dividerColor: Colors.transparent,
      labelColor: Get.theme.colorScheme.secondary,
      unselectedLabelColor:
          Get.theme.colorScheme.secondary.withValues(alpha: 0.5),
      tabs: const [
        Tab(text: 'Create Team'),
        Tab(text: 'Join Team'),
      ],
    );
  }
}
