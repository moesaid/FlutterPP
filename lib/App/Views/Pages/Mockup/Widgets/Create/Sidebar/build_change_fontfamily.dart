import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/change_fontfamily_controller.dart';
import 'package:flutterpp/App/Views/Global/build_full_page_bottomsheet.dart';
import 'package:get/get.dart';

class BuildChangeFontFamily extends GetView<ChangeFontfamilyController> {
  final TextStyle? fontFamily;

  const BuildChangeFontFamily({
    this.fontFamily,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangeFontfamilyController>(
      init: ChangeFontfamilyController(),
      didChangeDependencies: (state) {
        if (fontFamily == null) return;
        state.controller?.changeFontFamily(fontFamily: fontFamily!);
      },
      builder: (context) {
        return InkWell(
          onTap: () => Get.bottomSheet(
            BuildChangeFontBottomSheet(
              controller: controller,
            ),
            isDismissible: false,
            enableDrag: false,
            isScrollControlled: true,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Get.theme.primaryColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 0.5,
              ),
            ),
            child: const Row(
              children: [
                Expanded(child: Text('Font name')),
                Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BuildChangeFontBottomSheet extends StatelessWidget {
  final ChangeFontfamilyController controller;
  const BuildChangeFontBottomSheet({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return const BuildFullPageBottomSheet();
  }
}
