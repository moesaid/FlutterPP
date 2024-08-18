import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_analytics_item.dart';
import 'package:sizer/sizer.dart';

class BuildInvoiceAnalyticsSection extends StatelessWidget {
  final int? clients, invoices;
  final double? outstanding, overdue;
  const BuildInvoiceAnalyticsSection({
    super.key,
    this.clients,
    this.invoices,
    this.outstanding,
    this.overdue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.spa),
      child: Row(
        children: [
          Expanded(
            child: BuildInvoiceAnalyticsItem(
              title: 'clients',
              value: clients?.toString() ?? '0',
              unit: '',
            ),
          ),
          SizedBox(width: 6.spa),
          Expanded(
            child: BuildInvoiceAnalyticsItem(
              title: 'invoices',
              value: invoices?.toString() ?? '0',
              unit: '',
            ),
          ),
          SizedBox(width: 6.spa),
          Expanded(
            child: BuildInvoiceAnalyticsItem(
              unit: 'USD',
              title: 'outstanding',
              valueColor: Colors.green,
              value: outstanding?.toString() ?? '0',
            ),
          ),
          SizedBox(width: 6.spa),
          Expanded(
            child: BuildInvoiceAnalyticsItem(
              unit: 'USD',
              title: 'overdue',
              valueColor: Colors.redAccent,
              value: overdue?.toString() ?? '0',
            ),
          ),
        ],
      ),
    );
  }
}
