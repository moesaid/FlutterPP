import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Invoice/invoice_create_controller.dart';
import 'package:get/get.dart';

class InvoiceCreatePage extends GetView<InvoiceCreateController> {
  const InvoiceCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceCreateController>(
      init: InvoiceCreateController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('MyPage')),
          body: const SafeArea(child: Text('MyController')),
        );
      },
    );
  }
}
