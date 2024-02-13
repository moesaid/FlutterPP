import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_item.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/invoice_create_or_edit_create_item.dart';

class BuildInvoiceCreateOrEditItemsList extends StatelessWidget {
  final List<InvoiceItem>? items;
  final void Function(InvoiceItem)? callback;
  final void Function(InvoiceItem)? delete;
  const BuildInvoiceCreateOrEditItemsList({
    super.key,
    this.items,
    this.callback,
    this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items?.length ?? 0,
      separatorBuilder: (_, __) => const Divider(
        height: 0,
        thickness: 0.2,
      ),
      itemBuilder: (_, int index) {
        InvoiceItem item = items![index];
        return Column(
          children: [
            BuildInvoiceItem(
              inVerceColor: true,
              onDeleted: () => delete?.call(item),
              item: InvoiceItem(
                title: item.title,
                price: item.price,
                quantity: item.quantity,
              ),
            ),
            // if last item
            if (index == items!.length - 1)
              InvoiceCreateOrEditCreateItem(callback: callback),
          ],
        );
      },
    );
  }
}
