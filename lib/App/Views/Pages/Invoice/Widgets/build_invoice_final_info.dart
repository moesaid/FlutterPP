import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_final_info_item.dart';
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
              value: (invoice.currencySymbol ?? '\$') +
                  subTotal.toString().toPriceFormat(),
              discountValue: invoice.discount != null
                  ? invoice.discount.toString().toPriceFormat()
                  : '',
              taxValue: invoice.tax != null
                  ? '${invoice.tax.toString().toPriceFormat()}%'
                  : null,
            ),
            BuildInvoiceFinalInfoItem(
              title: 'total',
              value: (invoice.currencySymbol ?? '\$') +
                  total.toString().toPriceFormat(),
              borderWidht: 2,
            ),
            BuildInvoiceFinalInfoItem(
              title: 'total due (${(invoice.currency ?? 'USD')})',
              value:
                  '${invoice.currencySymbol ?? '\$'}${total.toString().toPriceFormat()} ',
              hasBorder: false,
              isAmount: true,
            ),
          ],
        ),
      ],
    );
  }
}
