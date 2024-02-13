import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Invoice/invoice_create_controller.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class InvoiceCreateOrEditFooterForm extends StatelessWidget {
  const InvoiceCreateOrEditFooterForm({
    super.key,
    required this.formFooterKey,
    required this.controller,
  });

  final GlobalKey<FormBuilderState> formFooterKey;
  final InvoiceCreateOrEditController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.sp),
      child: FormBuilder(
        key: formFooterKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: {
          'tax': controller.invoice.tax,
          'discount': controller.invoice.discount,
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: context.width * 0.2,
              child: FormBuilderTextField(
                name: 'discount',
                decoration: const InputDecoration(
                  labelText: 'Discount',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(),
                ]),
              ),
            ),
            SizedBox(height: 4.sp),
            SizedBox(
              width: context.width * 0.2,
              child: FormBuilderTextField(
                name: 'tax',
                decoration: const InputDecoration(
                  labelText: 'Tax',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
