import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildInvoiceFinalInfoItem extends StatelessWidget {
  final bool? isAmount, hasBorder;
  final String? title, value, discountValue, taxValue;
  final double? borderWidht;
  const BuildInvoiceFinalInfoItem({
    super.key,
    this.isAmount,
    this.title,
    this.value,
    this.discountValue,
    this.taxValue,
    this.borderWidht,
    this.hasBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 10.sp,
        top: 5.sp,
        bottom: 5.sp,
      ),
      width: context.width * 0.35,
      decoration: BoxDecoration(
        border: hasBorder == false
            ? null
            : Border(
                bottom: BorderSide(
                  color: Colors.black12,
                  width: borderWidht ?? 0.5,
                ),
              ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        isAmount == true
                            ? title?.toUpperCase() ?? ''
                            : title?.capitalize ?? '',
                        style: TextStyle(
                          fontSize: 5.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.sp),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        value ?? '',
                        style: TextStyle(
                          fontSize: 5.sp,
                          color: Colors.black,
                          fontWeight: isAmount == true ? FontWeight.bold : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (discountValue != null && discountValue!.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          'discount:'.capitalize!,
                          style: TextStyle(
                            fontSize: 5.sp,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.sp),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          discountValue ?? '',
                          style: TextStyle(
                            fontSize: 5.sp,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          if (taxValue != null && taxValue!.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          'tax:'.capitalize!,
                          style: TextStyle(
                            fontSize: 5.sp,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.sp),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          taxValue ?? '',
                          style: TextStyle(
                            fontSize: 5.sp,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
