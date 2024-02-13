import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Invoice/invoice_create_controller.dart';
import 'package:flutterpp/App/Models/client_model.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_create_or_edit_header.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_create_or_edit_items_list.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_item.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/invoice_create_or_edit_create_item.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/invoice_create_or_edit_footer.dart';
import 'package:get/get.dart';

class InvoiceCreateOrEditPage extends GetView<InvoiceCreateOrEditController> {
  final VoidCallback? onInvoiceCreate;
  final List<ClientModel> clients;
  final InvoiceModel? invoice;

  const InvoiceCreateOrEditPage({
    super.key,
    this.onInvoiceCreate,
    this.invoice,
    required this.clients,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceCreateOrEditController>(
      init: InvoiceCreateOrEditController(),
      didChangeDependencies: ((state) {
        if (state.controller == null) return;

        state.controller?.fetchApi(
          invoice: invoice,
          clintes: clients,
        );
      }),
      initState: (_) {},
      builder: (_) {
        final formHeaderKey = GlobalKey<FormBuilderState>();
        final formFooterKey = GlobalKey<FormBuilderState>();
        return Scaffold(
          backgroundColor: Get.theme.colorScheme.primaryContainer,
          body: SafeArea(
            child: BuildLoadingOrEmptyLayout(
              isLoading: controller.isLoading,
              isEmpty: clients.isEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildInvoiceCreateOrEditHeader(
                    controller: controller,
                    formKey: formHeaderKey,
                  ),
                  const BuildInvoiceItem(isHeader: true),
                  if (controller.customInvoice.items == null ||
                      controller.customInvoice.items!.isEmpty)
                    InvoiceCreateOrEditCreateItem(
                      callback: controller.onAddItem,
                    ),
                  Expanded(
                    child: BuildInvoiceCreateOrEditItemsList(
                      items: controller.customInvoice.items,
                      callback: controller.onAddItem,
                      delete: controller.onRemoveItem,
                    ),
                  ),
                  InvoiceCreateOrEditFooter(
                    controller: controller,
                    formHeaderKey: formHeaderKey,
                    formFooterKey: formFooterKey,
                    onInvoiceCreate: onInvoiceCreate,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
