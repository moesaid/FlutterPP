import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Invoice/invoice_single_controller.dart';
import 'package:flutterpp/App/Views/Global/build_appbar.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_printable_body.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_single_sidebar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class InvoiceSinglePage extends GetView<InvoiceSingleController> {
  const InvoiceSinglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceSingleController>(
      init: InvoiceSingleController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: const BuildAppBar(
            title: 'Invoice',
            hasBackButton: true,
          ),
          body: SafeArea(
            child: BuildLoadingOrEmptyLayout(
              isLoading: controller.isLoading,
              isEmpty: controller.invoice.id == null,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  BuildInvoiceSingleSidebar(
                    onDownload: controller.onDownload,
                    onEdit: controller.onEdit,
                    onPrint: controller.onPrint,
                  ),
                  const VerticalDivider(width: 0, thickness: 0.3),
                  Flexible(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.all(10.spa),
                      child: BuildInvoicePrintableBody(
                        invoice: controller.invoice,
                        team: controller.team,
                        client: controller.client,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
