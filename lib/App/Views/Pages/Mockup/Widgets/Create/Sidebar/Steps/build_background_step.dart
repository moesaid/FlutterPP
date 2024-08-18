import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/build_create_mockup_sidebar_selected_state_controller.dart';
import 'package:flutterpp/App/Models/background_type_model.dart';
import 'package:flutterpp/App/Models/gradient_model.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Widgets/build_color_preset_gradient.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Widgets/build_select_image_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Widgets/build_solid_color_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_sidebar_option.dart';
import 'package:get/get.dart';

ExpansionTileItem buildBackgroundStep({
  String? mockupId,
  Color? initialColor,
  GradientModel? activeGradient,
  void Function(String, {bool? repeatForAll})? onImageUpload,
  void Function(Color, {bool? repeatForAll})? onColorChangedCallback,
  void Function(GradientModel, {bool? repeatForAll})? onGradiantChangedCallback,
  required BuildCreateMockupSidebarSelectedStateController controller,
}) {
  return ExpansionTileItem(
    title: const Text('Background'),
    leading: const Icon(Icons.crop_original_rounded),
    collapsedBorderColor: Colors.transparent,
    collapsedTextColor: Colors.grey.withOpacity(0.8),
    collapsedIconColor: Colors.grey.withOpacity(0.8),
    expendedBorderColor: Colors.grey.withOpacity(0.2),
    textColor: Colors.white,
    iconColor: Colors.white,
    children: [
      GetBuilder<BuildCreateMockupSidebarSelectedStateController>(
        init: BuildCreateMockupSidebarSelectedStateController(),
        initState: (_) {},
        didChangeDependencies: (state) {
          state.controller?.updateActive();
        },
        builder: (_) {
          return BuildSidebarOption(
            title: 'Type',
            rightWidget: Obx(
              () => DropdownButton<String>(
                value: _.activeBackgroundType.name,
                icon: const Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.arrow_downward, size: 15),
                    ],
                  ),
                ),
                isDense: true,
                padding: EdgeInsets.zero,
                elevation: 0,
                focusColor: Colors.transparent,
                underline: Container(height: 0),
                onChanged: (String? value) {
                  controller.onSelectBackgroundType(name: value ?? '');
                },
                items:
                    controller.backgroundTypeList.map<DropdownMenuItem<String>>(
                  (BackgroundTypeModel el) {
                    return DropdownMenuItem<String>(
                      value: el.name,
                      child: Text(
                        el.name!.capitalize!,
                        style: Get.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          );
        },
      ),
      const Divider(height: 20),
      Obx(
        () => (controller.activeBackgroundType.id == 'solid')
            ? BuildSolidColorOption(
                initialColor: initialColor,
                onColorChangedCallback: onColorChangedCallback,
              )
            : (controller.activeBackgroundType.id == 'gradient')
                ? BuildColorPresetGradient(
                    name: controller.gradientName,
                    gradient: (controller.activeGradient.colors == null ||
                            controller.activeGradient.colors!.isEmpty)
                        ? activeGradient
                        : controller.activeGradient,
                    onSingleColorUpdate: (val, index) {
                      controller.updateSingleColor(val, index);
                      onGradiantChangedCallback?.call(
                        controller.activeGradient,
                      );
                    },
                    callback: (val) {
                      controller.onGradientSelect(val);
                      onGradiantChangedCallback?.call(val);
                    },
                    angleCallback: (val) {
                      controller.updateAngle(val);
                      onGradiantChangedCallback?.call(
                        controller.activeGradient,
                      );
                    },
                  )
                : BuildSelectImageOption(
                    mockupId: mockupId,
                    controllerTag: 'backgroundImage',
                    askForRepeat: true,
                    callbackForRepeat: (val, {repeatForAll}) {
                      onImageUpload?.call(val, repeatForAll: repeatForAll);
                    },
                  ),
      ),
    ],
  );
}
