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
        builder: (localController) {
          return FormBuilder(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: {
              'name': localController.activeClient.name,
              'contact_name': localController.activeClient.contactName,
              'email': localController.activeClient.email,
              'phone': localController.activeClient.phone,
              'address': localController.activeClient.address,
              'city': localController.activeClient.city,
              'state': localController.activeClient.state,
              'zip': localController.activeClient.zip,
              'country': localController.activeClient.country,
              'website': localController.activeClient.website,
              'internal_notes': localController.activeClient.internalNotes,
              'currency': localController.activeClient.currency,
              'currency_symbol': localController.activeClient.currencySymbol,
            },
            child: Stepper(
              type: StepperType.vertical,
              onStepContinue: () => localController.onStepContinue(formKey!),
              onStepTapped: localController.onStepTapped,
              currentStep: localController.currentStep,
              controlsBuilder: ((context, details) {
                return Column(
                  children: [
                    SizedBox(height: 4.spa),
                    Row(
                      children: [
                        if (localController.currentStep != 1)
                          FilledButton(
                            onPressed: details.onStepContinue,
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                Get.theme.colorScheme.secondaryContainer,
                              ),
                            ),
                            child: const Text('Next'),
                          ),
                        if (localController.currentStep == 1)
                          FilledButton(
                            onPressed: () =>
                                localController.onStepContinue(formKey!),
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
                  state: localController.currentStep == 0
                      ? StepState.editing
                      : StepState.indexed,
                  content: const BuildClientContactDialogStep(),
                ),
                Step(
                  title: const Text('Billing'),
                  subtitle: const Text('Client Billing Information'),
                  state: localController.currentStep == 1
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
