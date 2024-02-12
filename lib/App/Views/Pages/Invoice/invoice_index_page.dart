import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Invoice/invoice_index_controller.dart';
import 'package:flutterpp/App/Views/Global/build_custom_dropdown.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class InvoiceIndexPage extends GetView<InvoiceIndexController> {
  const InvoiceIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceIndexController>(
      init: InvoiceIndexController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                BuildInvoiceAnalyticsSection(
                  clients: controller.clients,
                  invoices: controller.invoices,
                  outstanding: controller.outstanding,
                  overdue: controller.overdue,
                ),
                BuildInvoiceFilterSection(
                  filter: controller.filter,
                  length: controller.length,
                  onCreate: () {
                    print('create');
                  },
                  onLengthChanged: controller.onLengthChange,
                  onFilterChanged: controller.onFilterChange,
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(10.sp),
                    itemCount: 20,
                    separatorBuilder: (_, __) {
                      return SizedBox(height: 5.sp);
                    },
                    itemBuilder: (_, int index) {
                      return InkWell(
                        onTap: () => controller.viewInvoice('view invoice'),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Get.theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(5.sp),
                          child: BuildInvoiceBody(
                            onView: controller.viewInvoice,
                            onEdit: controller.editInvoice,
                            onDelete: controller.deleteInvoice,
                            onDuplicate: controller.duplicateInvoice,
                            onExportAsPdf: controller.exportAsPdf,
                            onDownloadPdf: controller.exportAsPdf,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BuildInvoiceBody extends StatelessWidget {
  final String? status, date, clientName, amount, invoiceNumber, currency;
  final void Function(String)? onView,
      onEdit,
      onDelete,
      onDuplicate,
      onExportAsPdf,
      onDownloadPdf;

  const BuildInvoiceBody({
    super.key,
    this.status = 'status',
    this.date = 'date',
    this.clientName = 'client',
    this.amount = 'amount due',
    this.invoiceNumber = 'invoice number',
    this.currency = 'currency',
    this.onView,
    this.onEdit,
    this.onDelete,
    this.onDuplicate,
    this.onExportAsPdf,
    this.onDownloadPdf,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Badge(label: Text(status?.capitalize ?? '')),
        SizedBox(width: 8.sp),
        Text(date?.capitalize ?? ''),
        const Spacer(),
        Text(invoiceNumber?.capitalize ?? ''),
        SizedBox(width: 8.sp),
        Text(clientName?.capitalize ?? ''),
        const Spacer(),
        Text('${amount?.capitalize}  ${currency?.capitalize}'),
        const Spacer(),
        BuildCustomDropdown(
          items: [
            PopupMenuItem(
              onTap: onView != null ? () => onView?.call('view') : null,
              child: Row(
                children: [
                  Icon(Icons.remove_red_eye, size: 6.sp),
                  SizedBox(width: 2.sp),
                  Text('view'.capitalize!),
                ],
              ),
            ),
            PopupMenuItem(
              onTap: onEdit != null ? () => onEdit?.call('edit') : null,
              child: Row(
                children: [
                  Icon(Icons.edit, size: 6.sp),
                  SizedBox(width: 2.sp),
                  Text('edit'.capitalize!),
                ],
              ),
            ),
            PopupMenuItem(
              onTap: onDelete != null ? () => onDelete?.call('delete') : null,
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
                  ? () => onDuplicate?.call('duplicate')
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
                  ? () => onExportAsPdf?.call('export as pdf')
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
                  ? () => onDownloadPdf?.call('download pdf')
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
    );
  }
}

class BuildInvoiceFilterSection extends StatelessWidget {
  final Function(int)? onLengthChanged;
  final VoidCallback? onCreate;
  final Function(String)? onFilterChanged;
  final String filter;
  final int length;

  const BuildInvoiceFilterSection({
    super.key,
    this.onLengthChanged,
    this.onCreate,
    this.onFilterChanged,
    required this.filter,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Divider(thickness: 0.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: onFilterChanged != null
                  ? () => onFilterChanged?.call('draft')
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  filter == 'draft'
                      ? Get.theme.colorScheme.primary
                      : Get.theme.colorScheme.primaryContainer,
                ),
              ),
              child: Text('draft'.capitalize!),
            ),
            SizedBox(width: 3.sp),
            FilledButton(
              onPressed: onFilterChanged != null
                  ? () => onFilterChanged?.call('unpaid')
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  filter == 'unpaid'
                      ? Get.theme.colorScheme.primary
                      : Get.theme.colorScheme.primaryContainer,
                ),
              ),
              child: Text('unpaid'.capitalize!),
            ),
            SizedBox(width: 3.sp),
            FilledButton(
              onPressed: onFilterChanged != null
                  ? () => onFilterChanged?.call('paid')
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  filter == 'paid'
                      ? Get.theme.colorScheme.primary
                      : Get.theme.colorScheme.primaryContainer,
                ),
              ),
              child: Text('paid'.capitalize!),
            ),
          ],
        ),
        Positioned(
          left: 10.sp,
          child: FilledButton(
            onPressed: onCreate,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Get.theme.colorScheme.primaryContainer,
              ),
            ),
            child: Text('create'.capitalize!),
          ),
        ),
        Positioned(
          right: 10.sp,
          child: BuildCustomDropdown(
            items: [
              PopupMenuItem(
                onTap: onLengthChanged != null
                    ? () => onLengthChanged?.call(10)
                    : null,
                child: const Text('10'),
              ),
              PopupMenuItem(
                onTap: onLengthChanged != null
                    ? () => onLengthChanged?.call(40)
                    : null,
                child: const Text('40'),
              ),
              PopupMenuItem(
                onTap: onLengthChanged != null
                    ? () => onLengthChanged?.call(100)
                    : null,
                child: const Text('100'),
              ),
              PopupMenuItem(
                onTap: onLengthChanged != null
                    ? () => onLengthChanged?.call(1000)
                    : null,
                child: const Text('all'),
              ),
            ],
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 3.sp,
                vertical: 1.sp,
              ),
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(length.toString().capitalize!),
                  Icon(Icons.arrow_drop_down, size: 6.sp),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BuildInvoiceAnalyticsSection extends StatelessWidget {
  final int? clients, invoices, outstanding, overdue;
  const BuildInvoiceAnalyticsSection({
    super.key,
    this.clients,
    this.invoices,
    this.outstanding,
    this.overdue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Row(
        children: [
          Expanded(
            child: BuildInvoiceAnalyticsItem(
              title: 'clients',
              value: clients?.toString() ?? '0',
              unit: '',
            ),
          ),
          SizedBox(width: 6.sp),
          Expanded(
            child: BuildInvoiceAnalyticsItem(
              title: 'invoices',
              value: invoices?.toString() ?? '0',
              unit: '',
            ),
          ),
          SizedBox(width: 6.sp),
          Expanded(
            child: BuildInvoiceAnalyticsItem(
              title: 'outstanding',
              value: outstanding?.toString() ?? '0',
              unit: 'USD',
            ),
          ),
          SizedBox(width: 6.sp),
          Expanded(
            child: BuildInvoiceAnalyticsItem(
              title: 'overdue',
              value: overdue?.toString() ?? '0',
              unit: 'USD',
            ),
          ),
        ],
      ),
    );
  }
}

class BuildInvoiceAnalyticsItem extends StatelessWidget {
  final String? title, value, unit;
  const BuildInvoiceAnalyticsItem({
    super.key,
    this.title,
    this.value,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        border: Border.all(
          color: Get.theme.colorScheme.onBackground.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title?.capitalize ?? 'Total Invoices',
            style: Get.textTheme.titleMedium?.copyWith(
              color: Get.theme.colorScheme.onBackground.withOpacity(0.3),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value ?? '10',
                style: Get.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                unit ?? 'USD',
                style: Get.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w200,
                  color: Get.theme.colorScheme.onBackground.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
