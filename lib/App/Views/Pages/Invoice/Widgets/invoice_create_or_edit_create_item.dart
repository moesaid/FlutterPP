import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Views/Global/buiuld_dialog.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
