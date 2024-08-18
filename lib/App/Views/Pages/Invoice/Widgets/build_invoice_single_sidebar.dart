import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
        padding: EdgeInsets.all(6.0.spa),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton.icon(
              onPressed: onPrint,
              icon: Icon(Icons.print, size: 6.spa),
              label: Text('print'.capitalize!),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Get.theme.colorScheme.secondary,
                ),
              ),
            ),
            SizedBox(height: 3.spa),
            FilledButton.icon(
              onPressed: onDownload,
              icon: Icon(Icons.file_download, size: 6.spa),
              label: Text('download'.capitalize!),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Get.theme.colorScheme.secondary.withOpacity(0.6),
                ),
              ),
            ),
            Divider(thickness: 0.5, height: 14.spa),
            FilledButton.icon(
              onPressed: onEdit,
              icon: Icon(Icons.email, size: 6.spa),
              label: Text('Edit'.capitalize!),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
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
