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
              _buildLayoutStep(),
              _buildBackgroundStep(
                initialColor: initialColor,
                onImageUpload: onImageUpload,
                onColorChangedCallback: onColorChangedCallback,
                onGradiantChangedCallback: onGradiantChangedCallback,
              ),
              _buildingIconStep(
                isIconToggled: isIconToggled,
                onIconToggle: onIconToggle,
                onIconUpload: onIconUpload,
              ),
              _buildTitleStep(),
              _buildSubtitleStep(),
              _buildDeviceStep(),
              _buildDeviceStep(
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

  ExpansionTileBorderItem _buildDeviceStep({
    String? title,
    Widget? leading,
  }) {
    return ExpansionTileBorderItem(
      title: Text(title ?? 'Device'),
      leading: leading ?? const Icon(Icons.devices),
      collapsedBorderColor: Colors.transparent,
      collapsedTextColor: Colors.grey.withOpacity(0.8),
      collapsedIconColor: Colors.grey.withOpacity(0.8),
      expendedBorderColor: Colors.grey.withOpacity(0.2),
      textColor: Colors.white,
      iconColor: Colors.white,
      children: [
        const BuildSliderEnableOption(
          controllerTag: 'deviceEnable',
        ),
        const Divider(height: 30),
        const SizedBox(height: 10),
        const BuildAlignmentOption(
          title: '',
          controllerTag: 'deviceAlignmentHorizontal',
        ),
        const BuildAlignmentOption(
          title: '',
          controllerTag: 'deviceAlignmentVertical',
          firtIcon: Icons.vertical_align_top_rounded,
          secondIcon: Icons.vertical_align_center_rounded,
          thirdIcon: Icons.vertical_align_bottom_rounded,
        ),
        const SizedBox(height: 20),
        BuildSidebarOption(
          title: 'Screen',
          rightWidget: ElevatedButton(
            onPressed: () {},
            child: Text('add Screen'.capitalize!),
          ),
        ),
        const SizedBox(height: 10),
        BuildSidebarOption(
          title: 'Frame',
          rightWidget: ElevatedButton(
            onPressed: () {},
            child: Text('edit Frame'.capitalize!),
          ),
        ),
        const SizedBox(height: 20),
        BuildSidebarOption(
          title: 'Size',
          rightWidget: BuildSliderWithValueBox(
            controllerTag: 'deviceSize',
            onChanged: (val) => print('❌ - $val'),
          ),
        ),
        const SizedBox(height: 10),
        BuildSidebarOption(
          title: 'Rotate',
          rightWidget: BuildSliderWithValueBox(
            controllerTag: 'deviceRotate',
            onChanged: (val) => print('❌ - $val'),
          ),
        ),
        const SizedBox(height: 20),
        const BuildSidebarOption(
          title: 'Stroke',
          rightWidget: BuildPickColor(
            controllerTag: 'deviceStrokeColor',
          ),
        ),
        const SizedBox(height: 10),
        const BuildSidebarOption(
          title: 'Shadow',
          rightWidget: BuildPickColor(
            controllerTag: 'deviceShadowColor',
          ),
        ),
        const SizedBox(height: 10),
      ],
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

  ExpansionTileBorderItem _buildingIconStep({
    bool? isIconToggled,
    void Function(bool)? onIconToggle,
    void Function(String)? onIconUpload,
  }) {
    return ExpansionTileBorderItem(
      title: const Text('Icon'),
      leading: const Icon(Icons.invert_colors_on_sharp),
      collapsedBorderColor: Colors.transparent,
      collapsedTextColor: Colors.grey.withOpacity(0.8),
      collapsedIconColor: Colors.grey.withOpacity(0.8),
      expendedBorderColor: Colors.grey.withOpacity(0.2),
      textColor: Colors.white,
      iconColor: Colors.white,
      children: [
        BuildSliderEnableOption(
          controllerTag: 'iconEnable',
          initialValue: isIconToggled,
          onToggle: onIconToggle,
        ),
        const Divider(height: 30),
        const SizedBox(height: 10),
        BuildSidebarOption(
          title: 'logo',
          rightWidget: BuildSelectImageOption(
            mockupId: mockupId,
            controllerTag: 'logoImageUpload',
            title: 'add logo',
            callback: (val) => onIconUpload?.call(val),
          ),
        ),
        const SizedBox(height: 20),
        const BuildAlignmentOption(
          controllerTag: 'iconAlignmentHorizontal',
        ),
        const SizedBox(height: 20),
        BuildSidebarOption(
          title: 'Margin',
          rightWidget: BuildSlider(
            controllerTag: 'iconMargin',
            onChanged: (val) => print('❌ - $val'),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  ExpansionTileBorderItem _buildBackgroundStep({
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
                  items: controller.backgroundTypeList
                      .map<DropdownMenuItem<String>>(
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

  ExpansionTileBorderItem _buildLayoutStep() {
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
}

class _BuildColorPresetGradient extends StatelessWidget {
  final String? name;
  final GradientModel? gradient;
  final Function(GradientModel) callback;
  final Function(Color, int) onSingleColorUpdate;
  final void Function(double angle)? angleCallback;
  const _BuildColorPresetGradient({
    this.name,
    this.gradient,
    this.angleCallback,
    required this.callback,
    required this.onSingleColorUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildSidebarOption(
          title: 'preset',
          rightWidget: InkWell(
            onTap: () => aweSideSheet(
              context: context,
              sheetPosition: SheetPosition.right,
              title: 'Gradients',
              sheetWidth: context.width * 0.5,
              footer: const SizedBox.shrink(),
              body: BuildPresetGradientList(
                onGradientSelected: callback,
              ),
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
              child: Row(
                children: [
                  Expanded(
                    child: Text(name?.limitLength(10) ?? 'Gradient name'),
                  ),
                  const Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        BuildSidebarOption(
          title: 'Angle',
          rightWidget: BuildSlider(
            min: 0,
            max: 360,
            divisions: 360,
            controllerTag: 'gradiantAngle',
            onChanged: angleCallback,
          ),
        ),
        const SizedBox(height: 20),
        BuildSidebarOption(
          title: 'Color one',
          rightWidget: BuildPickColor(
            onColorChangedCallback: (val) => onSingleColorUpdate.call(val, 0),
            controllerTag: 'gradiantColorOne',
            initialColor: (gradient == null ||
                    gradient!.colors == null ||
                    gradient!.colors!.isEmpty)
                ? null
                : ColorHelper.hexToColor(gradient!.colors!.first),
          ),
        ),
        const SizedBox(height: 20),
        BuildSidebarOption(
          title: 'Color two',
          rightWidget: BuildPickColor(
            onColorChangedCallback: (val) => onSingleColorUpdate.call(val, 1),
            controllerTag: 'gradiantColorTwo',
            initialColor: (gradient == null ||
                    gradient!.colors == null ||
                    gradient!.colors!.isEmpty)
                ? null
                : ColorHelper.hexToColor(gradient!.colors!.last),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _BuildSolidColorOption extends StatelessWidget {
  final Color? initialColor;
  final void Function(Color)? onColorChangedCallback;
  const _BuildSolidColorOption({
    this.initialColor,
    this.onColorChangedCallback,
  });

  @override
  Widget build(BuildContext context) {
    return BuildSidebarOption(
      title: 'Color',
      rightWidget: BuildPickColor(
        controllerTag: 'solidColor',
        initialColor: initialColor,
        onColorChangedCallback: onColorChangedCallback,
      ),
    );
  }
}
