import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Invoice/invoice_create_controller.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/invoice_create_or_edit_footer_form.dart';
import 'package:sizer/sizer.dart';

class InvoiceCreateOrEditFooter extends StatelessWidget {
  const InvoiceCreateOrEditFooter({
    super.key,
    required this.controller,
    required this.formHeaderKey,
    required this.formFooterKey,
    this.onInvoiceCreate,
  });

  final InvoiceCreateOrEditController controller;
  final GlobalKey<FormBuilderState> formHeaderKey;
  final GlobalKey<FormBuilderState> formFooterKey;
  final VoidCallback? onInvoiceCreate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0.spa),
          child: ElevatedButton.icon(
            onPressed: () {
              controller.onSubmit(
                formHeaderKey: formHeaderKey,
                formFooterKey: formFooterKey,
                callback: onInvoiceCreate,
              );
            },
            icon: const Icon(Icons.account_balance_wallet),
            label: Text(
              controller.invoice.id == null
                  ? 'Create Invoice'
                  : 'Update Invoice',
              style: TextStyle(
                fontSize: 5.spa,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.0.spa),
              child: ElevatedButton(
                onPressed: () {
                  showCurrencyPicker(
                    context: context,
                    showFlag: true,
                    showCurrencyName: true,
                    showCurrencyCode: true,
                    onSelect: controller.updateCurrency,
                  );
                },
                child: Row(
                  children: [
                    Text(
                      controller.customInvoice.currency ?? 'USD',
                      style: TextStyle(
                        fontSize: 5.spa,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            InvoiceCreateOrEditFooterForm(
              formFooterKey: formFooterKey,
              controller: controller,
            ),
          ],
        ),
      ],
    );
  }
}
