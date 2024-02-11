import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Invoice/invoice_index_controller.dart';
import 'package:get/get.dart';

class InvoiceIndexPage extends GetView<InvoiceIndexController> {
  const InvoiceIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceIndexController>(
      init: InvoiceIndexController(),
      initState: (_) {},
      builder: (_) {
        return const Scaffold(
          body: SafeArea(child: Text('MyController')),
        );
      },
    );
  }
}
