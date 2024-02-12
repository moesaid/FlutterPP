import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/Helpers/text_helper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildInvoiceItem extends StatelessWidget {
  final bool? isHeader;
  final InvoiceItem? item;
  const BuildInvoiceItem({
    super.key,
    this.isHeader = false,
    this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isHeader == true ? Colors.black : Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: 4.0.sp,
        horizontal: 10.sp,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              isHeader == true ? 'items'.capitalize! : item?.title ?? '',
              style: TextStyle(
                fontSize: isHeader == true ? 6.sp : 4.5.sp,
                color: isHeader == true ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  isHeader == true
                      ? 'qty'.capitalize!
                      : item?.quantity.toString() ?? '',
                  style: TextStyle(
                    fontSize: isHeader == true ? 6.sp : 4.5.sp,
                    color: isHeader == true ? Colors.white : Colors.black,
                    fontWeight: isHeader == true ? FontWeight.bold : null,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  isHeader == true
                      ? 'price'.capitalize!
                      : item?.price.toString() ?? '',
                  style: TextStyle(
                    fontSize: isHeader == true ? 6.sp : 4.5.sp,
                    color: isHeader == true ? Colors.white : Colors.black,
                    fontWeight: isHeader == true ? FontWeight.bold : null,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  isHeader == true
                      ? 'total'.capitalize!
                      : ((item?.price ?? 0) * (item?.quantity ?? 0))
                          .toString()
                          .toPriceFormat(),
                  style: TextStyle(
                    fontSize: isHeader == true ? 6.sp : 4.5.sp,
                    color: isHeader == true ? Colors.white : Colors.black,
                    fontWeight: isHeader == true ? FontWeight.bold : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
