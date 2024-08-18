import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildInvoiceBodyHeader extends StatelessWidget {
  const BuildInvoiceBodyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                'Status',
                style: TextStyle(
                  color: Get.theme.colorScheme.onSurface.withOpacity(0.5),
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Due Date',
            style: TextStyle(
              color: Get.theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ),
        Expanded(
          child: Text(
            '#',
            style: TextStyle(
              color: Get.theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Client',
            style: TextStyle(
              color: Get.theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Amount',
                style: TextStyle(
                  color: Get.theme.colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 6.spa),
                child: Text(
                  'Actions',
                  style: TextStyle(
                    color: Get.theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
