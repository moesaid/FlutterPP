import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Invoice/invoice_index_controller.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_analytics_section.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_body.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_body_header.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_filter_section.dart';
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
