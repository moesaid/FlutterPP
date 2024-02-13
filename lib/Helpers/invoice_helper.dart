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

    // subtract discount
    if (invoice.discount != null) {
      total = total - double.parse(invoice.discount.toString());
    }

    // add tax
    if (invoice.tax != null) {
      total += (total * (invoice.tax ?? 0) / 100);
    }

    return total;
  }

  // total from list of invoice without tax and discount
  static double calculateSubtotal(InvoiceModel invoice) {
    double total = 0;

    if (invoice.items == null) return total;

    for (var item in invoice.items!) {
      total += (item.price ?? 0) * (item.quantity ?? 0);
    }

    return total;
  }

  // get status color
  static Color getStatusColor(String? status) {
    switch (status) {
      case 'paid':
        return Colors.green;
      case 'unpaid':
        return Colors.tealAccent;
      case 'draft':
        return Colors.blue;
      case 'sent':
        return Colors.purple;
      case 'viewed':
        return Colors.pink;
      case 'overdue':
        return Colors.red;
      case 'padding':
        return Colors.lime;

      default:
        return Colors.grey;
    }
  }

  // from date to yyyy-mm-dd
  static String fromDateToYMD(String? localDate) {
    if (localDate == null) return '';

    DateTime date = DateTime.parse(localDate);

    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
