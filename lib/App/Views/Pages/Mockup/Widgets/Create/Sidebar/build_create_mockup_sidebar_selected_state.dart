import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Mockup/build_create_mockup_sidebar_selected_state_controller.dart';
import 'package:flutterpp/App/Models/gradient_model.dart';
import 'package:flutterpp/App/Views/Global/build_slider.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Steps/build_background_step.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Steps/build_device_step.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Steps/build_icon_step.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/Steps/build_layout_step.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_alignment_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_change_fontfamily.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_pick_color.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_slider_enable_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_slider_with_value_box.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_sidebar_option.dart';
import 'package:get/get.dart';

class BuildCreateMockupSidebarSelectedState
    extends GetView<BuildCreateMockupSidebarSelectedStateController> {
  const BuildCreateMockupSidebarSelectedState({
    super.key,
    this.mockupId,
    this.initialColor,
    this.onImageUpload,
    this.onColorChangedCallback,
    this.onGradiantChangedCallback,
    this.activeGradient,
    this.onIconToggle,
    this.isIconToggled,
    this.onIconUpload,
  });

  final String? mockupId;
  final Color? initialColor;
  final void Function(Color)? onColorChangedCallback;
  final void Function(GradientModel)? onGradiantChangedCallback;
  final void Function(String)? onImageUpload;
  final GradientModel? activeGradient;
  final void Function(bool)? onIconToggle;
  final void Function(String)? onIconUpload;
  final bool? isIconToggled;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuildCreateMockupSidebarSelectedStateController>(
      init: BuildCreateMockupSidebarSelectedStateController(),
      initState: (_) {},
      builder: (_) {
        return SingleChildScrollView(
          child: ExpansionTileGroup(
            toggleType: ToggleType.expandOnlyCurrent,
            children: [
              buildLayoutStep(),
              buildBackgroundStep(
                mockupId: mockupId,
                controller: controller,
                initialColor: initialColor,
                onImageUpload: onImageUpload,
                activeGradient: activeGradient,
                onColorChangedCallback: onColorChangedCallback,
                onGradiantChangedCallback: onGradiantChangedCallback,
              ),
              buildingIconStep(
                mockupId: mockupId,
                isIconToggled: isIconToggled,
                onIconToggle: onIconToggle,
                onIconUpload: onIconUpload,
              ),
              _buildTitleStep(),
              _buildSubtitleStep(),
              buildDeviceStep(),
              buildDeviceStep(
                title: 'Device Two',
                leading: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.devices),
                    Icon(Icons.looks_two_outlined),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ExpansionTileBorderItem _buildSubtitleStep() {
    return ExpansionTileBorderItem(
      title: const Text('Subtitle'),
      leading: const Icon(Icons.text_increase),
      collapsedBorderColor: Colors.transparent,
      collapsedTextColor: Colors.grey.withOpacity(0.8),
      collapsedIconColor: Colors.grey.withOpacity(0.8),
      expendedBorderColor: Colors.grey.withOpacity(0.2),
      textColor: Colors.white,
      iconColor: Colors.white,
      children: [
        const BuildSliderEnableOption(
          controllerTag: 'subtitleEnable',
        ),
        const Divider(height: 30),
        const SizedBox(height: 10),
        const BuildAlignmentOption(
          controllerTag: 'subtitleAlignmentHorizontal',
        ),
        const SizedBox(height: 10),
        BuildSidebarOption(
          title: 'Font size',
          rightWidget: BuildSliderWithValueBox(
            controllerTag: 'subtitleFontSize',
            onChanged: (val) => print('❌ - $val'),
          ),
        ),
        const SizedBox(height: 10),
        BuildSidebarOption(
          title: 'Line Height',
          rightWidget: BuildSliderWithValueBox(
            controllerTag: 'subtitleLineHeight',
            onChanged: (val) => print('❌ - $val'),
          ),
        ),
        const SizedBox(height: 20),
        const BuildSidebarOption(
          title: 'Color',
          rightWidget: BuildPickColor(
            controllerTag: 'subtitleColor',
          ),
        ),
        const SizedBox(height: 20),
        const BuildSidebarOption(
          title: 'Stroke',
          rightWidget: BuildPickColor(
            controllerTag: 'subtitleStroke',
          ),
        ),
        const SizedBox(height: 20),
        BuildSidebarOption(
          title: 'Margin',
          rightWidget: BuildSlider(
            controllerTag: 'subtitleMargin',
            onChanged: (val) => print('❌ - $val'),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  ExpansionTileBorderItem _buildTitleStep() {
    return ExpansionTileBorderItem(
      title: const Text('Title'),
      leading: const Icon(Icons.text_fields),
      collapsedBorderColor: Colors.transparent,
      collapsedTextColor: Colors.grey.withOpacity(0.8),
      collapsedIconColor: Colors.grey.withOpacity(0.8),
      expendedBorderColor: Colors.grey.withOpacity(0.2),
      textColor: Colors.white,
      iconColor: Colors.white,
      children: [
        const BuildSliderEnableOption(
          controllerTag: 'titleEnable',
        ),
        const Divider(height: 30),
        const SizedBox(height: 10),
        FormBuilder(
          child: FormBuilderTextField(
            name: 'title',
            decoration: InputDecoration(
              hintText: 'your title',
              hintStyle: Get.textTheme.bodyMedium
                  ?.copyWith(color: Colors.grey.withOpacity(0.5)),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const BuildSidebarOption(
          title: 'Font family',
          rightWidget: BuildChangeFontFamily(),
        ),
        const SizedBox(height: 20),
        const BuildAlignmentOption(
          controllerTag: 'titleAlignmentHorizontal',
        ),
        const SizedBox(height: 20),
        BuildSidebarOption(
          title: 'Font size',
          rightWidget: BuildSliderWithValueBox(
            controllerTag: 'titleFontSize',
            onChanged: (val) => print('❌ - $val'),
          ),
        ),
        const SizedBox(height: 10),
        BuildSidebarOption(
          title: 'Line Height',
          rightWidget: BuildSliderWithValueBox(
            controllerTag: 'titleLineHeight',
            onChanged: (val) => print('❌ - $val'),
          ),
        ),
        const SizedBox(height: 20),
        const BuildSidebarOption(
          title: 'Color',
          rightWidget: BuildPickColor(),
        ),
        const SizedBox(height: 20),
        const BuildSidebarOption(
          title: 'Stroke',
          rightWidget: BuildPickColor(),
        ),
        const SizedBox(height: 20),
        BuildSidebarOption(
          title: 'Margin',
          rightWidget: BuildSlider(
            controllerTag: 'titleMargin',
            onChanged: (val) => print('❌ - $val'),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
