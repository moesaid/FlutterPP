import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sizer/sizer.dart';

class BuildClientContactDialogStep extends StatelessWidget {
  const BuildClientContactDialogStep({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 4.spa),
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
        SizedBox(height: 3.spa),
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
        SizedBox(height: 3.spa),
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
        SizedBox(height: 3.spa),
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
        SizedBox(height: 3.spa),
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
