import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Auth/setup_local_flutter_path_controller.dart';
import 'package:get/get.dart';

class SetupLocalFlutterPathPage
    extends GetView<SetupLocalFlutterPathController> {
  const SetupLocalFlutterPathPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetupLocalFlutterPathController>(
      init: SetupLocalFlutterPathController(),
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
