import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BuildInvoiceBodyHeader extends StatelessWidget {
  const BuildInvoiceBodyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Row(
            children: [Text('Status')],
          ),
        ),
        const Expanded(
          flex: 2,
          child: Text('Due Date'),
        ),
        const Expanded(
          child: Text('#'),
        ),
        const Expanded(
          flex: 2,
          child: Text('Client'),
        ),
        const Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Amount'),
            ],
          ),
        ),
        const Spacer(),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 6.sp),
                child: const Text('Actions'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
