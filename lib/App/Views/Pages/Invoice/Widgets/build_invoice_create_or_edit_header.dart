import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Invoice/invoice_create_controller.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_add_customer_buttom.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_create_or_edit_header_form.dart';
import 'package:sizer/sizer.dart';

class BuildInvoiceCreateOrEditHeader extends StatelessWidget {
  const BuildInvoiceCreateOrEditHeader({
    super.key,
    required this.controller,
    required this.formKey,
  });

  final InvoiceCreateOrEditController controller;
  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.spa),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BuildAddCustomerButtom(
            onPressed: controller.onClientSelected,
            client: controller.activeClient,
          ),
          BuildInvoiceCreateOrEditHeaderForm(
            formKey: formKey,
            controller: controller,
          ),
        ],
      ),
    );
  }
}
