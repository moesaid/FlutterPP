import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Mockup/build_create_mockup_sidebar_selected_state_controller.dart';
import 'package:flutterpp/App/Models/background_type_model.dart';
import 'package:flutterpp/App/Models/gradient_model.dart';
import 'package:flutterpp/App/Views/Global/build_preeset_gradient_list.dart';
import 'package:flutterpp/App/Views/Global/build_slider.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Widgets/build_select_image_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_alignment_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_change_fontfamily.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_pick_color.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_slider_enable_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_slider_with_value_box.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_sidebar_option.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:flutterpp/Helpers/text_helper.dart';
import 'package:get/get.dart';

ExpansionTileBorderItem buildBackgroundStep({
  required BuildCreateMockupSidebarSelectedStateController controller,
  Color? initialColor,
  final Function(String)? onImageUpload,
  final Function(Color)? onColorChangedCallback,
  final void Function(GradientModel)? onGradiantChangedCallback,
}) {
  return ExpansionTileBorderItem(
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
            ? _BuildSolidColorOption(
                initialColor: initialColor,
                onColorChangedCallback: onColorChangedCallback,
              )
            : (controller.activeBackgroundType.id == 'gradient')
                ? _BuildColorPresetGradient(
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
                    callback: (val) => onImageUpload?.call(val),
                  ),
      ),
    ],
  );
}
