import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/Micro/select_image_option_controller.dart';
import 'package:get/get.dart';

class BuildSelectImageOption extends StatelessWidget {
  final String? controllerTag, mockupId, title;

  final Function(String) callback;
  const BuildSelectImageOption({
    super.key,
    this.controllerTag,
    this.mockupId,
    this.title,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectImageOptionController>(
      init: SelectImageOptionController(),
      tag: controllerTag,
      initState: (_) {},
      builder: (_) {
        return ElevatedButton(
          onPressed: () => _.getImage(
            mockupId: mockupId,
            callback: callback,
          ),
          child: Text(title ?? 'add image'),
        );
      },
    );
  }
}
