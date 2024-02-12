import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Invoice/invoice_single_controller.dart';
import 'package:flutterpp/App/Views/Global/build_appbar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class InvoiceSinglePage extends GetView<InvoiceSingleController> {
  const InvoiceSinglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceSingleController>(
      init: InvoiceSingleController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: const BuildAppBar(
            title: 'Invoice',
            hasBackButton: true,
          ),
          body: SafeArea(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                const Flexible(
                  flex: 3,
                  child: BuildInvoiceBody(),
                ),
                const VerticalDivider(width: 0, thickness: 0.3),
                BuildInvoiceSingleSidebar(
                  onDownload: controller.onDownload,
                  onEdit: controller.onEdit,
                  onPrint: controller.onPrint,
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
  const BuildInvoiceBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.sp),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const BuildInvoiceOwnerSection(),
              Divider(thickness: 2, height: 4.sp, color: Colors.black12),
              const BuildInvoiceBillToSection(),
              const BuildInvoiceItemsSection(),
              Divider(thickness: 2, height: 4.sp, color: Colors.black12),
              const BuildInvoiceFinalInfo(),
              SizedBox(height: 30.sp),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildInvoiceFinalInfo extends StatelessWidget {
  const BuildInvoiceFinalInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            BuildInvoiceFinalInfoItem(
              title: 'subtotal',
              value: '\$1234',
              discountValue: '10%',
              taxValue: '\$123',
            ),
            BuildInvoiceFinalInfoItem(
              title: 'total',
              value: '\$1234',
              borderWidht: 2,
            ),
            BuildInvoiceFinalInfoItem(
              title: 'total due (USD)',
              value: '10%',
              hasBorder: false,
              isAmount: true,
            ),
          ],
        ),
      ],
    );
  }
}

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
      width: context.width * 0.3,
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

class BuildInvoiceItemsSection extends StatelessWidget {
  const BuildInvoiceItemsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BuildInvoiceItem(isHeader: true),
        ListView.separated(
          itemCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) {
            return Divider(
              thickness: 0.5,
              height: 0.5.sp,
              color: Colors.black12,
            );
          },
          itemBuilder: (_, int index) {
            return const BuildInvoiceItem();
          },
        ),
      ],
    );
  }
}

class BuildInvoiceItem extends StatelessWidget {
  final bool? isHeader;
  const BuildInvoiceItem({
    super.key,
    this.isHeader = false,
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
              'items'.capitalize!,
              style: TextStyle(
                fontSize: 6.sp,
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
                  'quantity'.capitalize!,
                  style: TextStyle(
                    fontSize: 6.sp,
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
                  'price'.capitalize!,
                  style: TextStyle(
                    fontSize: 6.sp,
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
                  'total'.capitalize!,
                  style: TextStyle(
                    fontSize: 6.sp,
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

class BuildInvoiceBillToSection extends StatelessWidget {
  const BuildInvoiceBillToSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'bill to'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 6.sp,
                    color: Colors.black45,
                  ),
                ),
                SizedBox(height: 2.sp),
                const BuildInvoiceCompanyInfo(
                  companyName: 'Apple',
                  ownerName: 'Steve Jobs',
                  address: '1234 Main Street',
                  city: 'Los Angeles',
                  state: 'CA',
                  zip: '90001',
                  country: 'United States',
                  phone: '123-456-7890',
                  email: 'steve@apple.com',
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                const BuildInvoiceHighlightsItem(
                  title: 'invoice number:',
                  value: '1234',
                ),
                SizedBox(height: 2.sp),
                const BuildInvoiceHighlightsItem(
                  title: 'invoice date:',
                  value: '12/12/2021',
                ),
                SizedBox(height: 2.sp),
                const BuildInvoiceHighlightsItem(
                  title: 'due date:',
                  value: '12/12/2021',
                ),
                SizedBox(height: 2.sp),
                Container(
                  padding: EdgeInsets.all(1.0.sp),
                  color: Colors.black12,
                  child: const BuildInvoiceHighlightsItem(
                    isAmount: true,
                    value: '\$1234',
                    title: 'amount due (USD):',
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
                    fontSize: 5.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 6.sp),
        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  value ?? '',
                  style: TextStyle(
                    fontSize: 5.sp,
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

class BuildInvoiceOwnerSection extends StatelessWidget {
  const BuildInvoiceOwnerSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'INVOICE',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 2.sp),
          const BuildInvoiceCompanyInfo(
            crossAxisAlignment: CrossAxisAlignment.end,
            companyName: 'tesla',
            ownerName: 'elon musk',
            address: '1234 Main Street',
            city: 'Los Angeles',
            state: 'CA',
            zip: '90001',
            country: 'United States',
            phone: '123-456-7890',
            email: 'elon@tesla.com',
          ),
        ],
      ),
    );
  }
}

class BuildInvoiceCompanyInfo extends StatelessWidget {
  final CrossAxisAlignment? crossAxisAlignment;
  final String? companyName,
      ownerName,
      address,
      city,
      state,
      zip,
      country,
      phone,
      email;
  const BuildInvoiceCompanyInfo({
    super.key,
    this.crossAxisAlignment,
    this.companyName,
    this.ownerName,
    this.address,
    this.city,
    this.country,
    this.phone,
    this.email,
    this.state,
    this.zip,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        if (companyName != null)
          Text(
            companyName!.toUpperCase(),
            style: TextStyle(
              fontSize: 6.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        if (ownerName != null)
          Text(
            ownerName!.capitalize!,
            style: TextStyle(
              fontSize: 5.sp,
              color: Colors.black87,
            ),
          ),
        if (address != null)
          Text(
            address!.capitalize!,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 5.sp,
              color: Colors.black87,
            ),
          ),
        if (city != null)
          Text(
            '${city!.capitalize!}, ${state?.capitalize ?? ''} ${zip ?? ''}',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 5.sp,
              color: Colors.black87,
            ),
          ),
        if (country != null)
          Text(
            country!.capitalize!,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 5.sp,
              color: Colors.black87,
            ),
          ),
        if (phone != null || email != null) SizedBox(height: 6.sp),
        if (phone != null)
          Text(
            phone!.toLowerCase(),
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 6.sp,
              color: Colors.black87,
            ),
          ),
        if (email != null)
          Text(
            email!.toLowerCase(),
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 6.sp,
              color: Colors.black87,
            ),
          ),
      ],
    );
  }
}

class BuildInvoiceSingleSidebar extends StatelessWidget {
  final VoidCallback onPrint, onDownload, onEdit;
  const BuildInvoiceSingleSidebar({
    super.key,
    required this.onPrint,
    required this.onDownload,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(6.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton.icon(
              onPressed: onPrint,
              icon: Icon(Icons.print, size: 6.sp),
              label: Text('print'.capitalize!),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Get.theme.colorScheme.secondary,
                ),
              ),
            ),
            SizedBox(height: 3.sp),
            FilledButton.icon(
              onPressed: onDownload,
              icon: Icon(Icons.file_download, size: 6.sp),
              label: Text('download'.capitalize!),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Get.theme.colorScheme.secondary.withOpacity(0.6),
                ),
              ),
            ),
            Divider(thickness: 0.5, height: 14.sp),
            FilledButton.icon(
              onPressed: onEdit,
              icon: Icon(Icons.email, size: 6.sp),
              label: Text('Edit'.capitalize!),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Get.theme.colorScheme.primaryContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
