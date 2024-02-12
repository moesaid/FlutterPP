import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Global/build_custom_dropdown.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildInvoiceFilterSection extends StatelessWidget {
  final Function(int)? onLengthChanged;
  final VoidCallback? onCreate;
  final Function(String)? onFilterChanged;
  final String filter;
  final int length;

  const BuildInvoiceFilterSection({
    super.key,
    this.onLengthChanged,
    this.onCreate,
    this.onFilterChanged,
    required this.filter,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Divider(thickness: 0.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: onFilterChanged != null
                  ? () => onFilterChanged?.call('all')
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  filter == 'all'
                      ? Get.theme.colorScheme.primary
                      : Get.theme.colorScheme.primaryContainer,
                ),
              ),
              child: Text('all'.capitalize!),
            ),
            SizedBox(width: 3.sp),
            FilledButton(
              onPressed: onFilterChanged != null
                  ? () => onFilterChanged?.call('draft')
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  filter == 'draft'
                      ? Get.theme.colorScheme.primary
                      : Get.theme.colorScheme.primaryContainer,
                ),
              ),
              child: Text('draft'.capitalize!),
            ),
            SizedBox(width: 3.sp),
            FilledButton(
              onPressed: onFilterChanged != null
                  ? () => onFilterChanged?.call('unpaid')
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  filter == 'unpaid'
                      ? Get.theme.colorScheme.primary
                      : Get.theme.colorScheme.primaryContainer,
                ),
              ),
              child: Text('unpaid'.capitalize!),
            ),
            SizedBox(width: 3.sp),
            FilledButton(
              onPressed: onFilterChanged != null
                  ? () => onFilterChanged?.call('paid')
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  filter == 'paid'
                      ? Get.theme.colorScheme.primary
                      : Get.theme.colorScheme.primaryContainer,
                ),
              ),
              child: Text('paid'.capitalize!),
            ),
          ],
        ),
        Positioned(
          left: 10.sp,
          child: FilledButton(
            onPressed: onCreate,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Get.theme.colorScheme.primaryContainer,
              ),
            ),
            child: Text('create'.capitalize!),
          ),
        ),
        Positioned(
          right: 10.sp,
          child: BuildCustomDropdown(
            items: [
              PopupMenuItem(
                onTap: onLengthChanged != null
                    ? () => onLengthChanged?.call(10)
                    : null,
                child: const Text('10'),
              ),
              PopupMenuItem(
                onTap: onLengthChanged != null
                    ? () => onLengthChanged?.call(40)
                    : null,
                child: const Text('40'),
              ),
              PopupMenuItem(
                onTap: onLengthChanged != null
                    ? () => onLengthChanged?.call(100)
                    : null,
                child: const Text('100'),
              ),
              PopupMenuItem(
                onTap: onLengthChanged != null
                    ? () => onLengthChanged?.call(1000)
                    : null,
                child: const Text('ALL'),
              ),
            ],
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 3.sp,
                vertical: 1.sp,
              ),
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(length == 1000 ? "ALL" : length.toString().capitalize!),
                  Icon(Icons.arrow_drop_down, size: 6.sp),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
