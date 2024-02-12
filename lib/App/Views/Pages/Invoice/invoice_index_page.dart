import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Invoice/invoice_index_controller.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Views/Global/build_custom_dropdown.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:flutterpp/Helpers/invoice_helper.dart';
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
                  clients: controller.clients.length,
                  invoices: controller.invoices.length,
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
                Container(
                  margin: EdgeInsets.only(
                    right: 10.0.sp,
                    left: 10.0.sp,
                    top: 20.sp,
                  ),
                  padding: EdgeInsets.only(
                    left: 5.0.sp,
                    right: 5.sp,
                    top: 5.sp,
                    bottom: 5.sp,
                  ),
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const BuildInvoiceBodyHeader(),
                ),
                Expanded(
                  child: BuildLoadingOrEmptyLayout(
                    isLoading: controller.isLoading,
                    isEmpty: controller.filteredInvoices.isEmpty,
                    title: 'No Invoices Found',
                    child: ListView.separated(
                      padding: EdgeInsets.all(10.sp),
                      itemCount: controller.filteredInvoices.length,
                      separatorBuilder: (_, __) {
                        return SizedBox(height: 5.sp);
                      },
                      itemBuilder: (_, int index) {
                        InvoiceModel invoice =
                            controller.filteredInvoices[index];

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
                              invoice: invoice,
                            ),
                          ),
                        );
                      },
                    ),
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
  final InvoiceModel invoice;
  final void Function(String)? onView,
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
                    onTap: onDelete != null
                        ? () => onDelete?.call('delete')
                        : null,
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
          ),
        ),
      ],
    );
  }
}

class BuildInvoiceBodyHeader extends StatelessWidget {
  const BuildInvoiceBodyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Row(
            children: [Text('Status')],
          ),
        ),
        const Expanded(
          flex: 2,
          child: Text('Due Date'),
        ),
        const Expanded(
          child: Text('#'),
        ),
        const Expanded(
          flex: 2,
          child: Text('Client'),
        ),
        const Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Amount'),
            ],
          ),
        ),
        const Spacer(),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 6.sp),
                child: const Text('Actions'),
              ),
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
                  ? () => onFilterChanged?.call('all')
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  filter == 'all'
                      ? Get.theme.colorScheme.primary
                      : Get.theme.colorScheme.primaryContainer,
                ),
              ),
              child: Text('all'.capitalize!),
            ),
            SizedBox(width: 3.sp),
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
                child: const Text('ALL'),
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
                  Text(length == 1000 ? "ALL" : length.toString().capitalize!),
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
  final int? clients, invoices;
  final double? outstanding, overdue;
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
              unit: 'USD',
              title: 'outstanding',
              valueColor: Colors.green,
              value: outstanding?.toString() ?? '0',
            ),
          ),
          SizedBox(width: 6.sp),
          Expanded(
            child: BuildInvoiceAnalyticsItem(
              unit: 'USD',
              title: 'overdue',
              valueColor: Colors.redAccent,
              value: overdue?.toString() ?? '0',
            ),
          ),
        ],
      ),
    );
  }
}

class BuildInvoiceAnalyticsItem extends StatelessWidget {
  final String? title, value, unit;
  final Color? valueColor;
  const BuildInvoiceAnalyticsItem({
    super.key,
    this.title,
    this.value,
    this.unit,
    this.valueColor,
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
            title?.capitalize ?? '',
            style: Get.textTheme.titleMedium?.copyWith(
              color: Get.theme.colorScheme.onBackground.withOpacity(0.5),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedFlipCounter(
                duration: const Duration(milliseconds: 500),
                value: num.parse(value ?? '0'),
                thousandSeparator: ',',
                decimalSeparator: '.',
                curve: Curves.easeInOut,
                textStyle: Get.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w200,
                  color: valueColor ?? Get.theme.colorScheme.onBackground,
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
