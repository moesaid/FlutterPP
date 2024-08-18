import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildInvoiceAnalyticsItem extends StatelessWidget {
  final String? title, value, unit;
  final Color? valueColor;
  const BuildInvoiceAnalyticsItem({
    super.key,
    this.title,
    this.value,
    this.unit,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.spa),
      decoration: BoxDecoration(
        border: Border.all(
          color: Get.theme.colorScheme.onSurface.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title?.capitalize ?? '',
            style: Get.textTheme.titleMedium?.copyWith(
              color: Get.theme.colorScheme.onSurface.withOpacity(0.5),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedFlipCounter(
                duration: const Duration(milliseconds: 500),
                value: num.parse(value ?? '0'),
                thousandSeparator: ',',
                decimalSeparator: '.',
                curve: Curves.easeInOut,
                textStyle: Get.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w200,
                  color: valueColor ?? Get.theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                unit ?? 'USD',
                style: Get.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w200,
                  color: Get.theme.colorScheme.onSurface.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
