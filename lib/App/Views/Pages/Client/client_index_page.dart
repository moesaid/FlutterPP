import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Clients/client_index_controller.dart';
import 'package:get/get.dart';

class ClientIndexPage extends GetView<ClientIndexController> {
  const ClientIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientIndexController>(
      init: ClientIndexController(),
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
