import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_body.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sizer/sizer.dart';

class BuildDashboardChart extends StatelessWidget {
  final List<InvoiceModel> invoices;
  final VoidCallback onMorePressed;

  const BuildDashboardChart({
    super.key,
    required this.invoices,
    required this.onMorePressed,
  });

  // limit invoices
  List<InvoiceModel> get _invoices {
    if (invoices.length > 5) {
      return invoices.sublist(0, 5);
    }
    return invoices;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: context.height * 0.23,
      padding: EdgeInsets.all(5.spa),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(3.spa),
        border: Border.all(
          width: 1,
          color: Get.theme.colorScheme.secondaryContainer,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'invoices'.toUpperCase(),
                style: TextStyle(
                  fontSize: 4.spa,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: onMorePressed,
                child: HeroIcon(
                  HeroIcons.chevronDoubleRight,
                  size: 4.spa,
                  color: Get.theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.spa),
          if (_invoices.isNotEmpty)
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: _invoices.length,
                separatorBuilder: (_, __) {
                  return const Divider(thickness: 0.5);
                },
                itemBuilder: (_, int index) {
                  InvoiceModel item = _invoices[index];
                  return BuildInvoiceBody(
                    invoice: item,
                    hasActions: false,
                    hasGrey: true,
                    hasDate: false,
                  );
                },
              ),
            ),
          if (_invoices.isEmpty)
            Center(
              child: Text(
                'no invoices yet'.capitalize!,
                style: TextStyle(
                  fontSize: 4.spa,
                  color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
