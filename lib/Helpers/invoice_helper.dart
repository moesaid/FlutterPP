import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';

class InvoiceHelper {
  static double calculateInvoiceTotal(InvoiceModel invoice) {
    double total = 0;

    if (invoice.items != null) {
      for (var item in invoice.items!) {
        total += (item.price ?? 0) * (item.quantity ?? 0);
      }
    }

    // add tax
    if (invoice.tax != null) {
      total += (total * (invoice.tax ?? 0) / 100);
    }

    // subtract discount
    if (invoice.discount != null) {
      total = total - double.parse(invoice.discount.toString());
    }

    return total;
  }

  // get status color
  static Color getStatusColor(String? status) {
    switch (status) {
      case 'paid':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'draft':
        return Colors.blue;
      case 'sent':
        return Colors.purple;
      case 'viewed':
        return Colors.pink;
      case 'overdue':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
