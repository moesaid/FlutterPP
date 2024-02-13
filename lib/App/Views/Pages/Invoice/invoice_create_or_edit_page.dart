import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Invoice/invoice_create_controller.dart';
import 'package:flutterpp/App/Models/client_model.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:flutterpp/App/Views/Global/buiuld_dialog.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_add_customer_buttom.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_item.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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

class InvoiceCreateOrEditCreateItem extends StatelessWidget {
  final void Function(InvoiceItem)? callback;

  const InvoiceCreateOrEditCreateItem({
    super.key,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) {
            final formKey = GlobalKey<FormBuilderState>();
            return BuildDefultDialog(
              height: 300,
              child: FormBuilder(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Add invoice Item'.capitalize!),
                    SizedBox(height: 4.sp),
                    FormBuilderTextField(
                      name: 'title',
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    SizedBox(height: 4.sp),
                    FormBuilderTextField(
                      name: 'price',
                      decoration: const InputDecoration(
                        labelText: 'Price',
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                    ),
                    SizedBox(height: 4.sp),
                    FormBuilderTextField(
                      name: 'quantity',
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.saveAndValidate()) {
                          final Map<String, dynamic> values =
                              formKey.currentState!.value;
                          final InvoiceItem item = InvoiceItem(
                            title: values['title'],
                            price: int.tryParse(values['price'])!,
                            quantity: int.tryParse(values['quantity'])!,
                          );
                          callback?.call(item);
                          Get.back();
                        }
                      },
                      child: const Text('Add Item'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(5.sp),
        decoration: BoxDecoration(
          color: Colors.black26,
          border: Border(
            top: BorderSide(
              color: Get.theme.colorScheme.secondary,
              width: 2,
            ),
            bottom: BorderSide(
              color: Get.theme.colorScheme.secondaryContainer,
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 5.sp),
            SizedBox(width: 1.sp),
            Text(
              'add item'.capitalize!,
              style: TextStyle(
                fontSize: 5.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvoiceCreateOrEditFooter extends StatelessWidget {
  const InvoiceCreateOrEditFooter({
    super.key,
    required this.controller,
    required this.formHeaderKey,
    required this.formFooterKey,
    this.onInvoiceCreate,
  });

  final InvoiceCreateOrEditController controller;
  final GlobalKey<FormBuilderState> formHeaderKey;
  final GlobalKey<FormBuilderState> formFooterKey;
  final VoidCallback? onInvoiceCreate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: ElevatedButton.icon(
            onPressed: () {
              controller.onSubmit(
                formHeaderKey: formHeaderKey,
                formFooterKey: formFooterKey,
                callback: onInvoiceCreate,
              );
            },
            icon: const Icon(Icons.account_balance_wallet),
            label: Text(
              controller.invoice.id == null
                  ? 'Create Invoice'
                  : 'Update Invoice',
              style: TextStyle(
                fontSize: 5.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.0.sp),
              child: ElevatedButton(
                onPressed: () {
                  showCurrencyPicker(
                    context: context,
                    showFlag: true,
                    showCurrencyName: true,
                    showCurrencyCode: true,
                    onSelect: controller.updateCurrency,
                  );
                },
                child: Row(
                  children: [
                    Text(
                      controller.customInvoice.currency ?? 'USD',
                      style: TextStyle(
                        fontSize: 5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            InvoiceCreateOrEditFooterForm(
              formFooterKey: formFooterKey,
              controller: controller,
            ),
          ],
        ),
      ],
    );
  }
}

class InvoiceCreateOrEditFooterForm extends StatelessWidget {
  const InvoiceCreateOrEditFooterForm({
    super.key,
    required this.formFooterKey,
    required this.controller,
  });

  final GlobalKey<FormBuilderState> formFooterKey;
  final InvoiceCreateOrEditController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.sp),
      child: FormBuilder(
        key: formFooterKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: {
          'tax': controller.invoice.tax,
          'discount': controller.invoice.discount,
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: context.width * 0.2,
              child: FormBuilderTextField(
                name: 'discount',
                decoration: const InputDecoration(
                  labelText: 'Discount',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(),
                ]),
              ),
            ),
            SizedBox(height: 4.sp),
            SizedBox(
              width: context.width * 0.2,
              child: FormBuilderTextField(
                name: 'tax',
                decoration: const InputDecoration(
                  labelText: 'Tax',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildInvoiceCreateOrEditHeader extends StatelessWidget {
  const BuildInvoiceCreateOrEditHeader({
    super.key,
    required this.controller,
    required this.formKey,
  });

  final InvoiceCreateOrEditController controller;
  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BuildAddCustomerButtom(
            onPressed: controller.onClientSelected,
            client: controller.activeClient,
          ),
          BuildInvoiceCreateOrEditHeaderForm(
            formKey: formKey,
            controller: controller,
          ),
        ],
      ),
    );
  }
}

class BuildInvoiceCreateOrEditHeaderForm extends StatelessWidget {
  const BuildInvoiceCreateOrEditHeaderForm({
    super.key,
    required this.formKey,
    required this.controller,
  });

  final GlobalKey<FormBuilderState> formKey;
  final InvoiceCreateOrEditController controller;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: {
        'number': controller.invoice.number?.toString(),
        'date': DateTime.parse(
            controller.invoice.createdAt ?? DateTime.now().toString()),
        'dueDate': DateTime.parse(
            controller.invoice.dueDate ?? DateTime.now().toString()),
      },
      child: SizedBox(
        width: context.width * 0.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FormBuilderTextField(
              name: 'number',
              decoration: const InputDecoration(
                labelText: 'Invoice Number',
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
              ]),
            ),
            SizedBox(height: 4.sp),
            FormBuilderDateTimePicker(
              name: 'date',
              inputType: InputType.date,
              decoration: const InputDecoration(
                labelText: 'Invoice Date',
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            SizedBox(height: 4.sp),
            FormBuilderDateTimePicker(
              name: 'dueDate',
              inputType: InputType.date,
              decoration: const InputDecoration(
                labelText: 'Due Date',
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
