import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuiuldDialog extends StatelessWidget {
  final Widget? child;
  const BuiuldDialog({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        height: 500,
        width: 500,
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: child ??
            const Center(
              child: Text('Modal'),
            ),
      ),
    );
  }
}
