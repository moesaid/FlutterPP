import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Invoice/invoice_create_controller.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildInvoiceCreateOrEditHeaderForm extends StatelessWidget {
  const BuildInvoiceCreateOrEditHeaderForm({
    super.key,
    required this.formKey,
    required this.controller,
  });

  final GlobalKey<FormBuilderState> formKey;
  final InvoiceCreateOrEditController controller;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: {
        'number': controller.invoice.number?.toString(),
        'date': DateTime.parse(
            controller.invoice.createdAt ?? DateTime.now().toString()),
        'dueDate': DateTime.parse(
            controller.invoice.dueDate ?? DateTime.now().toString()),
      },
      child: SizedBox(
        width: context.width * 0.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FormBuilderTextField(
              name: 'number',
              decoration: const InputDecoration(
                labelText: 'Invoice Number',
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
              ]),
            ),
            SizedBox(height: 4.spa),
            FormBuilderDateTimePicker(
              name: 'date',
              inputType: InputType.date,
              decoration: const InputDecoration(
                labelText: 'Invoice Date',
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            SizedBox(height: 4.spa),
            FormBuilderDateTimePicker(
              name: 'dueDate',
              inputType: InputType.date,
              decoration: const InputDecoration(
                labelText: 'Due Date',
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
