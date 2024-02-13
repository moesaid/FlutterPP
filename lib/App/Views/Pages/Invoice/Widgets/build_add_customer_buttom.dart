import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/client_model.dart';
import 'package:flutterpp/App/Views/Pages/Client/Widgets/build_client_list.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_company_info.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
      onTap: client?.id == null ? () => _openSheet(context) : null,
      child: client?.id == null
          ? Container(
              width: context.width * 0.2,
              height: context.height * 0.2,
              decoration: BoxDecoration(
                color:
                    Get.theme.colorScheme.secondaryContainer.withOpacity(0.2),
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
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildInvoiceCompanyInfo(
                  inVerseColor: true,
                  companyName: client?.name,
                  address: client?.address,
                  city: client?.city,
                  country: client?.country,
                  ownerName: client?.contactName,
                  state: client?.state,
                  zip: client?.zip,
                  email: client?.email,
                  phone: client?.phone,
                ),
                SizedBox(height: 4.sp),
                InkWell(
                  onTap: () => _openSheet(context),
                  child: Text(
                    'change customer'.capitalize!,
                    style: TextStyle(
                      color: Get.theme.colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _openSheet(BuildContext context) {
    return aweSideSheet(
      context: context,
      sheetPosition: SheetPosition.right,
      title: 'choose a client',
      footer: const SizedBox.shrink(),
      body: Padding(
        padding: EdgeInsets.all(4.sp),
        child: BuildClientList(onClientSelected: onPressed),
      ),
    );
  }
}
