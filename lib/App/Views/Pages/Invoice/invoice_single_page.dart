import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Invoice/invoice_single_controller.dart';
import 'package:get/get.dart';

class InvoiceSinglePage extends GetView<InvoiceSingleController> {
  const InvoiceSinglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceSingleController>(
      init: InvoiceSingleController(),
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
