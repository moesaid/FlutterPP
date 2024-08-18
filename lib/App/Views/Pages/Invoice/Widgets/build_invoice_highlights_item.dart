import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildInvoiceHighlightsItem extends StatelessWidget {
  final String? title, value;
  final bool? isAmount;
  const BuildInvoiceHighlightsItem({
    super.key,
    this.title,
    this.value,
    this.isAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      direction: Axis.horizontal,
      children: [
        Flexible(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  isAmount != null
                      ? title?.toUpperCase() ?? ''
                      : title?.capitalize ?? '',
                  style: TextStyle(
                    fontSize: 5.spa,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 6.spa),
        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  value ?? '',
                  style: TextStyle(
                    fontSize: 5.spa,
                    color: isAmount != null
                        ? Colors.black
                        : Colors.black.withOpacity(0.6),
                    fontWeight: isAmount != null ? FontWeight.bold : null,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
