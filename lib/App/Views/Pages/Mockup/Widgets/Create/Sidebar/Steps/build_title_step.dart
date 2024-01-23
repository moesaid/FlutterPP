import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Views/Global/build_slider.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_alignment_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_change_fontfamily.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_pick_color.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_slider_enable_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_slider_with_value_box.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_sidebar_option.dart';
import 'package:get/get.dart';

ExpansionTileBorderItem buildTitleStep() {
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
