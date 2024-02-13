import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Global/buiuld_dialog.dart';
import 'package:flutterpp/Helpers/invoice_helper.dart';
import 'package:sizer/sizer.dart';

class BuildInvoiceStatusDialog extends StatelessWidget {
  final void Function(String)? onStatusChanged;
  const BuildInvoiceStatusDialog({
    super.key,
    this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BuildDefultDialog(
      height: 100,
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Change Status'),
          SizedBox(height: 5.sp),
          SizedBox(
            height: 10.sp,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: [
                'draft',
                'unpaid',
                'paid',
              ].length,
              separatorBuilder: (_, __) {
                return SizedBox(width: 2.sp);
              },
              itemBuilder: (_, index) {
                String status = [
                  'draft',
                  'unpaid',
                  'paid',
                ][index];
                return InkWell(
                  onTap: () => onStatusChanged?.call(status),
                  child: Badge(
                    label: Text(status),
                    padding: EdgeInsets.symmetric(horizontal: 3.sp),
                    textColor: InvoiceHelper.getStatusColor(status),
                    backgroundColor:
                        InvoiceHelper.getStatusColor(status).withOpacity(0.1),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
