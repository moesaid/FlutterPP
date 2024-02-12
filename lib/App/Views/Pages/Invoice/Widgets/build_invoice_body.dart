import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Views/Global/build_custom_dropdown.dart';
import 'package:flutterpp/Helpers/invoice_helper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildInvoiceBody extends StatelessWidget {
  final InvoiceModel invoice;
  final void Function(InvoiceModel)? onView,
      onEdit,
      onDelete,
      onDuplicate,
      onExportAsPdf,
      onDownloadPdf;

  const BuildInvoiceBody({
    super.key,
    this.onView,
    this.onEdit,
    this.onDelete,
    this.onDuplicate,
    this.onExportAsPdf,
    this.onDownloadPdf,
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
              Badge(
                label: Text(invoice.status?.capitalize ?? ''),
                padding: EdgeInsets.symmetric(horizontal: 3.sp),
                textColor: InvoiceHelper.getStatusColor(invoice.status),
                backgroundColor: InvoiceHelper.getStatusColor(invoice.status)
                    .withOpacity(0.1),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(invoice.dueDate?.capitalize ?? ''),
        ),
        Expanded(
          child: Text(invoice.number.toString()),
        ),
        Expanded(
          flex: 2,
          child: Text(invoice.clientName?.capitalize ?? ''),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: totalAmount.toString(),
                ),
                TextSpan(
                  text: '  ${(invoice.currency?.toUpperCase() ?? '')}',
                  style: TextStyle(
                    color: Get.theme.colorScheme.onBackground.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BuildCustomDropdown(
                items: [
                  PopupMenuItem(
                    onTap: onView != null ? () => onView?.call(invoice) : null,
                    child: Row(
                      children: [
                        Icon(Icons.remove_red_eye, size: 6.sp),
                        SizedBox(width: 2.sp),
                        Text('view'.capitalize!),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: onEdit != null ? () => onEdit?.call(invoice) : null,
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 6.sp),
                        SizedBox(width: 2.sp),
                        Text('edit'.capitalize!),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap:
                        onDelete != null ? () => onDelete?.call(invoice) : null,
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 6.sp),
                        SizedBox(width: 2.sp),
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
                        Icon(Icons.copy, size: 6.sp),
                        SizedBox(width: 2.sp),
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
                        Icon(Icons.picture_as_pdf, size: 6.sp),
                        SizedBox(width: 2.sp),
                        Text('export as pdf'.capitalize!),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: onDownloadPdf != null
                        ? () => onDownloadPdf?.call(invoice)
                        : null,
                    child: Row(
                      children: [
                        Icon(Icons.download, size: 6.sp),
                        SizedBox(width: 2.sp),
                        Text('download pdf'.capitalize!),
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
