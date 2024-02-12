import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/invoice_single_page.dart';
import 'package:sizer/sizer.dart';

class BuildInvoiceItemsSection extends StatelessWidget {
  final InvoiceModel invoice;
  const BuildInvoiceItemsSection({
    super.key,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BuildInvoiceItem(isHeader: true),
        if (invoice.items != null && invoice.items!.isNotEmpty)
          ListView.separated(
            itemCount: invoice.items!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) {
              return Divider(
                thickness: 0.5,
                height: 0.5.sp,
                color: Colors.black12,
              );
            },
            itemBuilder: (_, int index) {
              return BuildInvoiceItem(item: invoice.items![index]);
            },
          ),
      ],
    );
  }
}
