import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sizer/sizer.dart';

class BuildClientBillingDialogStep extends StatelessWidget {
  const BuildClientBillingDialogStep({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 4.spa),
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
        SizedBox(height: 3.spa),
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
        SizedBox(height: 3.spa),
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
        SizedBox(height: 3.spa),
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
        SizedBox(height: 3.spa),
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
