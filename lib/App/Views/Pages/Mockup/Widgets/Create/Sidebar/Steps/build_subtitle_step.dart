import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Global/build_slider.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_alignment_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_pick_color.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_slider_enable_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_slider_with_value_box.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_sidebar_option.dart';

ExpansionTileBorderItem buildSubtitleStep() {
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
