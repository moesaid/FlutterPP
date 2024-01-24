import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Enums/padding_destination_enum.dart';
import 'package:flutterpp/App/Views/Global/build_slider.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_alignment_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_change_fontfamily.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_pick_color.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_slider_enable_option.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_slider_with_value_box.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_sidebar_option.dart';
import 'package:get/get.dart';

ExpansionTileBorderItem buildTitleStep({
  String? titleText,
  String? titleFontFamily,
  bool? showTitle,
  MainAxisAlignment? titleAlignment,
  double? titleFontSize,
  double? titleLineHeight,
  Color? titleColor,
  Color? titleStrokeColor,
  double? titlePaddingTop,
  double? titlePaddingBottom,
  double? titlePaddingLeft,
  double? titlePaddingRight,
  required BuildContext titleSheetContext,
  Function(bool)? onShowTitleChanged,
  Function(String)? onTitleChanged,
  Function(MainAxisAlignment)? onTitleAlignmentChanged,
  Function(double)? onTitleFontSizeChanged,
  Function(double)? onTitleLineHeightChanged,
  Function(Color)? onTitleColorChanged,
  Function(double, PaddingDestination)? onTitlePaddingChanged,
}) {
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
      BuildSliderEnableOption(
        controllerTag: 'titleEnable',
        initialValue: showTitle,
        onToggle: onShowTitleChanged,
      ),
      const Divider(height: 30),
      const SizedBox(height: 10),
      FormBuilder(
        child: FormBuilderTextField(
          name: 'title',
          onChanged: (val) => onTitleChanged?.call(val!),
          decoration: InputDecoration(
            hintText: titleText,
            hintStyle: Get.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.withOpacity(0.5),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
      const SizedBox(height: 20),
      BuildSidebarOption(
        title: 'Font family',
        rightWidget: BuildChangeFontFamily(sheetContext: titleSheetContext),
      ),
      const SizedBox(height: 20),
      BuildAlignmentOption(
        controllerTag: 'titleAlignmentHorizontal',
        initialAlignment: titleAlignment,
        onToggle: (val) => onTitleAlignmentChanged?.call(val),
      ),
      const SizedBox(height: 20),
      BuildSidebarOption(
        title: 'Font size',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: 'titleFontSize',
          defaultValue: titleFontSize ?? 20,
          onChanged: (val) => onTitleFontSizeChanged?.call(val),
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'Line Height',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: 'titleLineHeight',
          defaultValue: titleLineHeight ?? 1,
          min: -0,
          max: 5,
          divisions: 20,
          onChanged: (val) => onTitleLineHeightChanged?.call(val),
        ),
      ),
      const SizedBox(height: 20),
      BuildSidebarOption(
        title: 'Color',
        rightWidget: BuildPickColor(
          controllerTag: 'titleColor',
          initialColor: titleColor,
          onColorChangedCallback: (val) => onTitleColorChanged?.call(val),
        ),
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
