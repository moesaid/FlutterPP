import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/team_model.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_company_info.dart';
import 'package:sizer/sizer.dart';

class BuildInvoiceOwnerSection extends StatelessWidget {
  final TeamModel team;
  const BuildInvoiceOwnerSection({
    super.key,
    required this.team,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.spa),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'INVOICE',
            style: TextStyle(
              fontSize: 14.spa,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 2.spa),
          BuildInvoiceCompanyInfo(
            crossAxisAlignment: CrossAxisAlignment.end,
            companyName: team.name,
            ownerName: team.ownerName,
            address: team.address,
            city: team.city,
            state: team.state,
            zip: team.zip.toString(),
            country: team.country,
            phone: team.phone,
            email: team.email,
          ),
        ],
      ),
    );
  }
}
