import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/client_model.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Models/team_model.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_bill_to_section.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_final_info.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_items_section.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_owner_section.dart';
import 'package:sizer/sizer.dart';

class BuildInvoicePrintableBody extends StatelessWidget {
  final InvoiceModel invoice;
  final TeamModel team;
  final ClientModel client;
  const BuildInvoicePrintableBody({
    super.key,
    required this.invoice,
    required this.team,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.sp),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              BuildInvoiceOwnerSection(team: team),
              Divider(thickness: 2, height: 4.sp, color: Colors.black12),
              BuildInvoiceBillToSection(client: client, invoice: invoice),
              BuildInvoiceItemsSection(invoice: invoice),
              Divider(thickness: 2, height: 4.sp, color: Colors.black12),
              BuildInvoiceFinalInfo(invoice: invoice),
              SizedBox(height: 30.sp),
            ],
          ),
        ),
      ),
    );
  }
}
