import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Views/Global/build_custom_dropdown.dart';
import 'package:flutterpp/Helpers/invoice_helper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildInvoiceBody extends StatelessWidget {
  final InvoiceModel invoice;
  final bool? hasActions, hasGrey, hasDate;
  final void Function(InvoiceModel)? onView,
      onEdit,
      onDelete,
      onDuplicate,
      onExportAsPdf,
      printInvoice,
      onStatusPressed;

  const BuildInvoiceBody({
    super.key,
    this.onView,
    this.onEdit,
    this.onDelete,
    this.onDuplicate,
    this.onExportAsPdf,
    this.printInvoice,
    this.onStatusPressed,
    this.hasActions = true,
    this.hasGrey = false,
    this.hasDate = true,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    double totalAmount = InvoiceHelper.calculateInvoiceTotal(invoice);
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              InkWell(
                onTap: () => onStatusPressed?.call(invoice),
                child: Badge(
                  label: Text(invoice.status?.capitalize ?? ''),
                  padding: EdgeInsets.symmetric(horizontal: 3.spa),
                  textColor: InvoiceHelper.getStatusColor(invoice.status),
                  backgroundColor: InvoiceHelper.getStatusColor(invoice.status)
                      .withValues(alpha: 0.1),
                ),
              ),
            ],
          ),
        ),
        if (hasDate == true)
          Expanded(
            flex: 2,
            child: Text(
              invoice.dueDate?.capitalize ?? '',
              style: TextStyle(
                color: Get.theme.colorScheme.onSurface
                    .withValues(alpha: hasGrey == true ? 0.5 : 1),
              ),
            ),
          ),
        Expanded(
          child: Text(
            invoice.number.toString(),
            style: TextStyle(
              color: Get.theme.colorScheme.onSurface
                  .withValues(alpha: hasGrey == true ? 0.5 : 1),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            invoice.clientName?.capitalize ?? '',
            style: TextStyle(
              color: Get.theme.colorScheme.onSurface
                  .withValues(alpha: hasGrey == true ? 0.5 : 1),
            ),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: totalAmount.toString(),
                  style: TextStyle(
                    color: Get.theme.colorScheme.onSurface
                        .withValues(alpha: hasGrey == true ? 0.5 : 1),
                  ),
                ),
                TextSpan(
                  text: '  ${(invoice.currency?.toUpperCase() ?? '')}',
                  style: TextStyle(
                    color: Get.theme.colorScheme.onSurface
                        .withValues(alpha: hasGrey == true ? 0.1 : 0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (hasActions == true) const Spacer(),
        if (hasActions == true)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BuildCustomDropdown(
                  items: [
                    PopupMenuItem(
                      onTap:
                          onView != null ? () => onView?.call(invoice) : null,
                      child: Row(
                        children: [
                          Icon(Icons.remove_red_eye, size: 6.spa),
                          SizedBox(width: 2.spa),
                          Text('view'.capitalize!),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap:
                          onEdit != null ? () => onEdit?.call(invoice) : null,
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 6.spa),
                          SizedBox(width: 2.spa),
                          Text('edit'.capitalize!),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: onDelete != null
                          ? () => onDelete?.call(invoice)
                          : null,
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 6.spa),
                          SizedBox(width: 2.spa),
                          Text('delete'.capitalize!),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: onDuplicate != null
                          ? () => onDuplicate?.call(invoice)
                          : null,
                      child: Row(
                        children: [
                          Icon(Icons.copy, size: 6.spa),
                          SizedBox(width: 2.spa),
                          Text('duplicate'.capitalize!),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: onExportAsPdf != null
                          ? () => onExportAsPdf?.call(invoice)
                          : null,
                      child: Row(
                        children: [
                          Icon(Icons.picture_as_pdf, size: 6.spa),
                          SizedBox(width: 2.spa),
                          Text('export as pdf'.capitalize!),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: printInvoice != null
                          ? () => printInvoice?.call(invoice)
                          : null,
                      child: Row(
                        children: [
                          Icon(Icons.print, size: 6.spa),
                          SizedBox(width: 2.spa),
                          Text('print invoice'.capitalize!),
                        ],
                      ),
                    ),
                  ],
                  child: Row(
                    children: [
                      Text('actions'.capitalize!),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
