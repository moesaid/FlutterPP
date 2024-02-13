import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Invoice/invoice_create_controller.dart';
import 'package:flutterpp/App/Models/client_model.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:flutterpp/App/Views/Pages/Client/Widgets/build_client_list.dart';
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
                            onPressed: (val) => print(val.toJson()),
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

class BuildAddCustomerButtom extends StatelessWidget {
  final void Function(ClientModel)? onPressed;
  final ClientModel? client;
  const BuildAddCustomerButtom({
    super.key,
    this.onPressed,
    this.client,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        aweSideSheet(
          context: context,
          sheetPosition: SheetPosition.right,
          title: 'choose a client',
          footer: const SizedBox.shrink(),
          body: Padding(
            padding: EdgeInsets.all(4.sp),
            child: BuildClientList(onClientSelected: onPressed),
          ),
        );
      },
      child: Container(
        width: context.width * 0.2,
        height: context.height * 0.2,
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.secondaryContainer.withOpacity(0.2),
          border: Border.all(
            color: Get.theme.colorScheme.secondaryContainer,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add_rounded),
              Text('add a customer'.capitalize!),
            ],
          ),
        ),
      ),
    );
  }
}
