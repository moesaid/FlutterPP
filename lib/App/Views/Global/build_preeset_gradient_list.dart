import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Global/build_appbar.dart';
import 'package:flutterpp/App/Views/Global/build_close_button.dart';
import 'package:get/get.dart';

class BuildPresetGradientList extends StatelessWidget {
  const BuildPresetGradientList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.primaryContainer.withOpacity(0.95),
      appBar: const BuildAppBar(title: 'Gradients'),
      body: Stack(
        children: [
          const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('list'),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: BuildCloseButton(
              bgColor: Get.theme.colorScheme.secondary.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
