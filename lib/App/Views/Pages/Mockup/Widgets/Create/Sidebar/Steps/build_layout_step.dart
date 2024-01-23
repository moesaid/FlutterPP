import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

ExpansionTileBorderItem buildLayoutStep() {
  return ExpansionTileBorderItem(
    title: const Text('Layout'),
    leading: const Icon(Icons.crop_free),
    collapsedBorderColor: Colors.transparent,
    collapsedTextColor: Colors.grey.withOpacity(0.8),
    collapsedIconColor: Colors.grey.withOpacity(0.8),
    expendedBorderColor: Colors.grey.withOpacity(0.2),
    textColor: Colors.white,
    iconColor: Colors.white,
    children: [
      InkWell(
        onTap: () => print('open layout dialog'),
        child: Container(
          padding: const EdgeInsets.all(10),
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
              Expanded(child: Text('Screen name')),
              Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
