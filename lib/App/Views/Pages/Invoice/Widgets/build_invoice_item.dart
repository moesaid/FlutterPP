import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/Helpers/text_helper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildInvoiceItem extends StatelessWidget {
  final bool? isHeader, inVerceColor;
  final InvoiceItem? item;
  final VoidCallback? onDeleted;
  const BuildInvoiceItem({
    super.key,
    this.isHeader = false,
    this.inVerceColor = false,
    this.item,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          color: isHeader == true
              ? Colors.black
              : inVerceColor == true
                  ? Colors.black26
                  : Colors.white,
          padding: EdgeInsets.symmetric(
            vertical: 4.0.spa,
            horizontal: 10.spa,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  isHeader == true ? 'items'.capitalize! : item?.title ?? '',
                  style: TextStyle(
                    fontSize: isHeader == true ? 6.sp : 4.5.spa,
                    color: isHeader == true
                        ? Colors.white
                        : inVerceColor == true
                            ? Colors.white
                            : Colors.black,
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
                        fontSize: isHeader == true ? 6.sp : 4.5.spa,
                        color: isHeader == true
                            ? Colors.white
                            : inVerceColor == true
                                ? Colors.white
                                : Colors.black,
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
                        fontSize: isHeader == true ? 6.sp : 4.5.spa,
                        color: isHeader == true
                            ? Colors.white
                            : inVerceColor == true
                                ? Colors.white
                                : Colors.black,
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
                        fontSize: isHeader == true ? 6.sp : 4.5.spa,
                        color: isHeader == true
                            ? Colors.white
                            : inVerceColor == true
                                ? Colors.white
                                : Colors.black,
                        fontWeight: isHeader == true ? FontWeight.bold : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (onDeleted != null)
          Positioned(
            top: 3.spa,
            left: 1.spa,
            child: IconButton(
              onPressed: onDeleted,
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              hoverColor: Colors.transparent,
              constraints: const BoxConstraints(),
              icon: Icon(
                Icons.delete,
                size: 7.spa,
                color: Get.theme.colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }
}
