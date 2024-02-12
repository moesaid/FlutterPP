import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Invoice/invoice_index_controller.dart';
import 'package:flutterpp/App/Views/Global/build_custom_dropdown.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class InvoiceIndexPage extends GetView<InvoiceIndexController> {
  const InvoiceIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceIndexController>(
      init: InvoiceIndexController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const BuildInvoiceAnalyticsSection(),
                const BuildInvoiceFilterSection(),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(10.sp),
                    itemCount: 20,
                    separatorBuilder: (_, __) {
                      return SizedBox(height: 5.sp);
                    },
                    itemBuilder: (_, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Get.theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(5.sp),
                        child: const BuildInvoiceBody(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BuildInvoiceBody extends StatelessWidget {
  final String? status, date, clientName, amount, invoiceNumber, currency;

  const BuildInvoiceBody({
    super.key,
    this.status = 'status',
    this.date = 'date',
    this.clientName = 'client',
    this.amount = 'amount due',
    this.invoiceNumber = 'invoice number',
    this.currency = 'currency',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Badge(label: Text(status?.capitalize ?? '')),
        SizedBox(width: 8.sp),
        Text(date?.capitalize ?? ''),
        const Spacer(),
        Text(invoiceNumber?.capitalize ?? ''),
        SizedBox(width: 8.sp),
        Text(clientName?.capitalize ?? ''),
        const Spacer(),
        Text('${amount?.capitalize}  ${currency?.capitalize}'),
        const Spacer(),
        BuildCustomDropdown(
          child: Row(
            children: [
              Text('actions'.capitalize!),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ],
    );
  }
}

class BuildInvoiceFilterSection extends StatelessWidget {
  const BuildInvoiceFilterSection({
    super.key,
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
              onPressed: () {},
              child: Text('draft'.capitalize!),
            ),
            SizedBox(width: 3.sp),
            FilledButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Get.theme.colorScheme.primaryContainer,
                ),
              ),
              child: Text('unpaid'.capitalize!),
            ),
            SizedBox(width: 3.sp),
            FilledButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Get.theme.colorScheme.primaryContainer,
                ),
              ),
              child: Text('paid'.capitalize!),
            ),
          ],
        ),
        Positioned(
          left: 10.sp,
          child: FilledButton(
            onPressed: () {},
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
                  Text('10'.capitalize!),
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

class BuildInvoiceAnalyticsSection extends StatelessWidget {
  const BuildInvoiceAnalyticsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Row(
        children: [
          const Expanded(
            child: BuildInvoiceAnalyticsItem(
              title: 'clients',
              value: '10',
              unit: '',
            ),
          ),
          SizedBox(width: 6.sp),
          const Expanded(
            child: BuildInvoiceAnalyticsItem(
              title: 'invoices',
              value: '10',
              unit: '',
            ),
          ),
          SizedBox(width: 6.sp),
          const Expanded(
            child: BuildInvoiceAnalyticsItem(
              title: 'outstanding',
              value: '10',
              unit: 'USD',
            ),
          ),
          SizedBox(width: 6.sp),
          const Expanded(
            child: BuildInvoiceAnalyticsItem(
              title: 'overdue',
              value: '10',
              unit: 'USD',
            ),
          ),
        ],
      ),
    );
  }
}

class BuildInvoiceAnalyticsItem extends StatelessWidget {
  final String? title, value, unit;
  const BuildInvoiceAnalyticsItem({
    super.key,
    this.title,
    this.value,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        border: Border.all(
          color: Get.theme.colorScheme.onBackground.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title?.capitalize ?? 'Total Invoices',
            style: Get.textTheme.titleMedium?.copyWith(
              color: Get.theme.colorScheme.onBackground.withOpacity(0.3),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value ?? '10',
                style: Get.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                unit ?? 'USD',
                style: Get.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w200,
                  color: Get.theme.colorScheme.onBackground.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
