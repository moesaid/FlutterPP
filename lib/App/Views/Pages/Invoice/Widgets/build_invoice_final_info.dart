import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/invoice_single_page.dart';
import 'package:flutterpp/Helpers/invoice_helper.dart';
import 'package:flutterpp/Helpers/text_helper.dart';

class BuildInvoiceFinalInfo extends StatelessWidget {
  final InvoiceModel invoice;
  const BuildInvoiceFinalInfo({
    super.key,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    double subTotal = InvoiceHelper.calculateSubtotal(invoice);
    double total = InvoiceHelper.calculateInvoiceTotal(invoice);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            BuildInvoiceFinalInfoItem(
              title: 'subtotal',
              value: subTotal.toString().toPriceFormat(),
              discountValue: invoice.discount.toString().toPriceFormat(),
              taxValue: '${invoice.tax.toString().toPriceFormat()}%',
            ),
            BuildInvoiceFinalInfoItem(
              title: 'total',
              value: total.toString().toPriceFormat(),
              borderWidht: 2,
            ),
            BuildInvoiceFinalInfoItem(
              title: 'total due (USD)',
              value:
                  '${total.toString().toPriceFormat()} ${invoice.currency?.toUpperCase() ?? ''}',
              hasBorder: false,
              isAmount: true,
            ),
          ],
        ),
      ],
    );
  }
}
