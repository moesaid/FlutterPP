import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Invoice/invoice_create_controller.dart';
import 'package:flutterpp/App/Models/client_model.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_add_customer_buttom.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class InvoiceCreatePage extends GetView<InvoiceCreateController> {
  final VoidCallback? onInvoiceCreate;
  final List<ClientModel> clients;
  final InvoiceModel? invoice;

  const InvoiceCreatePage({
    super.key,
    this.onInvoiceCreate,
    this.invoice,
    required this.clients,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceCreateController>(
      init: InvoiceCreateController(),
      didChangeDependencies: ((state) {
        if (state.controller == null) return;

        state.controller?.fetchApi(
          invoice: invoice,
          clintes: clients,
        );
      }),
      initState: (_) {},
      builder: (_) {
        final formKey = GlobalKey<FormBuilderState>();
        return Scaffold(
          backgroundColor: Get.theme.colorScheme.primaryContainer,
          body: SafeArea(
            child: BuildLoadingOrEmptyLayout(
              isLoading: controller.isLoading,
              isEmpty: clients.isEmpty,
              child: FormBuilder(
                key: formKey,
                initialValue: {
                  'number': controller.invoice.number,
                  'date': controller.invoice.createdAt,
                  'dueDate': controller.invoice.dueDate,
                },
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BuildAddCustomerButtom(
                            onPressed: controller.onClientSelected,
                            client: controller.activeClient,
                          ),
                          const Text('MyController'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
