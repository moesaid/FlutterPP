import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Clients/client_index_controller.dart';
import 'package:flutterpp/App/Views/Global/buiuld_dialog.dart';
import 'package:flutterpp/App/Views/Pages/Client/Widgets/build_client_billing_dialog_step.dart';
import 'package:flutterpp/App/Views/Pages/Client/Widgets/build_client_contact_dialog_step.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildClientCreateOrEditDialog extends StatelessWidget {
  final GlobalKey<FormBuilderState>? formKey;

  const BuildClientCreateOrEditDialog({
    super.key,
    this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return BuildDefultDialog(
      child: GetBuilder<ClientIndexController>(
        init: ClientIndexController(),
        initState: (_) {},
        builder: (_) {
          return FormBuilder(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: {
              'name': _.activeClient.name,
              'contact_name': _.activeClient.contactName,
              'email': _.activeClient.email,
              'phone': _.activeClient.phone,
              'address': _.activeClient.address,
              'city': _.activeClient.city,
              'state': _.activeClient.state,
              'zip': _.activeClient.zip,
              'country': _.activeClient.country,
              'website': _.activeClient.website,
            },
            child: Stepper(
              type: StepperType.vertical,
              onStepContinue: () => _.onStepContinue(formKey!),
              onStepTapped: _.onStepTapped,
              currentStep: _.currentStep,
              controlsBuilder: ((context, details) {
                return Column(
                  children: [
                    SizedBox(height: 4.sp),
                    Row(
                      children: [
                        if (_.currentStep != 1)
                          FilledButton(
                            onPressed: details.onStepContinue,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Get.theme.colorScheme.secondaryContainer,
                              ),
                            ),
                            child: const Text('Next'),
                          ),
                        if (_.currentStep == 1)
                          FilledButton(
                            onPressed: () => _.onStepContinue(formKey!),
                            child: const Text('Save'),
                          ),
                      ],
                    ),
                  ],
                );
              }),
              steps: [
                Step(
                  title: const Text('Contact'),
                  subtitle: const Text('Client Contact Information'),
                  state: _.currentStep == 0
                      ? StepState.editing
                      : StepState.indexed,
                  content: const BuildClientContactDialogStep(),
                ),
                Step(
                  title: const Text('Billing'),
                  subtitle: const Text('Client Billing Information'),
                  state: _.currentStep == 1
                      ? StepState.editing
                      : StepState.indexed,
                  content: const BuildClientBillingDialogStep(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
