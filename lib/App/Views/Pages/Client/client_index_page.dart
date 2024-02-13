import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Clients/client_index_controller.dart';
import 'package:flutterpp/App/Models/client_model.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:flutterpp/App/Views/Global/buiuld_dialog.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ClientIndexPage extends GetView<ClientIndexController> {
  const ClientIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientIndexController>(
      init: ClientIndexController(),
      initState: (_) {},
      builder: (_) {
        final formKey = GlobalKey<FormBuilderState>();
        return Scaffold(
          body: SafeArea(
            child: BuildLoadingOrEmptyLayout(
              isLoading: controller.isLoading,
              isEmpty: controller.clients.isEmpty,
              hasButton: true,
              buttonText: 'create your first client'.capitalize!,
              onButtonPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => BuildClientCreateOrEditDialog(
                    formKey: formKey,
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: Row(
                      children: [
                        Text(
                          'All Clients',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        SizedBox(width: 2.sp),
                        Text(
                          '(${controller.clients.length})',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Get.theme.colorScheme.secondary,
                          ),
                        ),
                        const Spacer(),
                        FilledButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => BuildClientCreateOrEditDialog(
                                formKey: formKey,
                              ),
                            );
                          },
                          child: const Text('Create Client'),
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 0.5),
                  Expanded(
                    child: BuildClientIndexGrid(
                      controller: controller,
                      formKey: formKey,
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

class BuildClientIndexGrid extends StatelessWidget {
  const BuildClientIndexGrid({
    super.key,
    required this.controller,
    required this.formKey,
  });

  final ClientIndexController controller;
  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
        childAspectRatio: 1.5,
      ),
      itemCount: controller.clients.length,
      padding: EdgeInsets.all(3.sp),
      itemBuilder: (_, int index) {
        ClientModel item = controller.clients[index];
        return InkWell(
          onTap: () {
            controller.updateActiveClient(
              controller.clients[index],
            );

            showDialog(
              context: context,
              builder: (_) => BuildClientCreateOrEditDialog(
                formKey: formKey,
              ),
            );
          },
          child: Card(
            elevation: 0,
            color: Get.theme.colorScheme.primaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 3.sp,
                    vertical: 1.sp,
                  ),
                  title: Text(
                    controller.clients[index].name ?? '',
                    style: Get.textTheme.titleSmall!,
                  ),
                  subtitle: Text(
                    controller.clients[index].email ?? '',
                    style: Get.textTheme.labelSmall,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: controller.clients[index].logo == null
                        ? Get.theme.colorScheme.secondary
                        : Get.theme.colorScheme.secondaryContainer,
                    foregroundImage: controller.clients[index].logo == null
                        ? null
                        : NetworkImage(controller.clients[index].logo!),
                    child: controller.clients[index].logo == null
                        ? Text(controller.clients[index].name?[0] ?? '')
                        : null,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.all(6.sp),
                  child: Text(
                    '${item.address ?? ''}, \n${item.city ?? ''}, ${item.state ?? ''}, ${item.zip ?? ''}, \n${item.country ?? ''}',
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.bodySmall,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

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

class BuildClientBillingDialogStep extends StatelessWidget {
  const BuildClientBillingDialogStep({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 4.sp),
        FormBuilderTextField(
          name: 'address',
          decoration: const InputDecoration(
            hintText: '123 Main St',
            labelText: 'Address',
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
        SizedBox(height: 3.sp),
        FormBuilderTextField(
          name: 'city',
          decoration: const InputDecoration(
            hintText: 'Los Angeles',
            labelText: 'City',
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
        SizedBox(height: 3.sp),
        FormBuilderTextField(
          name: 'state',
          decoration: const InputDecoration(
            hintText: 'CA',
            labelText: 'State',
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
        SizedBox(height: 3.sp),
        FormBuilderTextField(
          name: 'zip',
          decoration: const InputDecoration(
            hintText: '12345',
            labelText: 'Zip',
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.numeric(),
          ]),
        ),
        SizedBox(height: 3.sp),
        FormBuilderTextField(
          name: 'country',
          decoration: const InputDecoration(
            hintText: 'USA',
            labelText: 'Country',
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
      ],
    );
  }
}

class BuildClientContactDialogStep extends StatelessWidget {
  const BuildClientContactDialogStep({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 4.sp),
        FormBuilderTextField(
          name: 'name',
          decoration: const InputDecoration(
            hintText: 'Tesla',
            labelText: 'Client Name',
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
        SizedBox(height: 3.sp),
        FormBuilderTextField(
          name: 'contact_name',
          decoration: const InputDecoration(
            hintText: 'Elon Musk',
            labelText: 'Contact Name',
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
        SizedBox(height: 3.sp),
        FormBuilderTextField(
          name: 'email',
          decoration: const InputDecoration(
            hintText: 'elon@tesla.com',
            labelText: 'Client Email',
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ]),
        ),
        SizedBox(height: 3.sp),
        FormBuilderTextField(
          name: 'phone',
          decoration: const InputDecoration(
            hintText: '1234567890',
            labelText: 'Client Phone',
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.numeric(),
          ]),
        ),
        SizedBox(height: 3.sp),
        FormBuilderTextField(
          name: 'website',
          decoration: const InputDecoration(
            hintText: 'https://tesla.com',
            labelText: 'Client Website',
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.url(),
          ]),
        ),
      ],
    );
  }
}
