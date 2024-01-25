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
import 'package:uuid/uuid.dart';

ExpansionTileBorderItem buildTitleStep({
  String? widgetTitle = 'title',
  String? titleText,
  String? titleFontFamily,
  bool? showTitle,
  MainAxisAlignment? titleAlignment,
  double? titleFontSize,
  double? titleLineHeight,
  Color? titleColor,
  double? titlePaddingTop,
  double? titlePaddingBottom,
  double? titlePaddingLeft,
  double? titlePaddingRight,
  required BuildContext titleSheetContext,
  Function(bool)? onShowTitleChanged,
  Function(String)? onTitleChanged,
  Function(MainAxisAlignment)? onTitleAlignmentChanged,
  Function(double)? onTitleFontSizeChanged,
  Function(String)? onTitleFontFamilyChanged,
  Function(double)? onTitleLineHeightChanged,
  Function(Color)? onTitleColorChanged,
  Function(double, PaddingDestination)? onTitlePaddingChanged,
}) {
  String uuid = const Uuid().v1();
  return ExpansionTileBorderItem(
    title: Text(widgetTitle!),
    leading: const Icon(Icons.text_fields),
    collapsedBorderColor: Colors.transparent,
    collapsedTextColor: Colors.grey.withOpacity(0.8),
    collapsedIconColor: Colors.grey.withOpacity(0.8),
    expendedBorderColor: Colors.grey.withOpacity(0.2),
    textColor: Colors.white,
    iconColor: Colors.white,
    children: [
      BuildSliderEnableOption(
        controllerTag: '$widgetTitle-Enable-$uuid',
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
        rightWidget: BuildChangeFontFamily(
          sheetContext: titleSheetContext,
          fontFamily: titleFontFamily,
          callback: (val) => onTitleFontFamilyChanged?.call(val),
        ),
      ),
      const SizedBox(height: 20),
      BuildAlignmentOption(
        controllerTag: '$widgetTitle-AlignmentHorizontal-$uuid',
        initialAlignment: titleAlignment,
        onToggle: (val) => onTitleAlignmentChanged?.call(val),
      ),
      const SizedBox(height: 20),
      BuildSidebarOption(
        title: 'Font size',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: '$widgetTitle-titleFontSize-$uuid',
          defaultValue: titleFontSize ?? 20,
          max: 30,
          onChanged: (val) => onTitleFontSizeChanged?.call(val),
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'Line Height',
        rightWidget: BuildSliderWithValueBox(
          controllerTag: '$widgetTitle-titleLineHeight-$uuid',
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
          controllerTag: '$widgetTitle-titleColor-$uuid',
          initialColor: titleColor,
          onColorChangedCallback: (val) => onTitleColorChanged?.call(val),
        ),
      ),
      const Divider(height: 40),
      const Text('Padding'),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'Top',
        rightWidget: BuildSlider(
          min: 0,
          max: 30,
          controllerTag: '$widgetTitle-titlePadding-top-$uuid',
          onChanged: (val) => onTitlePaddingChanged?.call(
            val,
            PaddingDestination.top,
          ),
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'Bottom',
        rightWidget: BuildSlider(
          min: 0,
          max: 30,
          controllerTag: '$widgetTitle-titlePadding-bottom-$uuid',
          onChanged: (val) => onTitlePaddingChanged?.call(
            val,
            PaddingDestination.bottom,
          ),
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'Left',
        rightWidget: BuildSlider(
          min: 0,
          max: 30,
          controllerTag: '$widgetTitle-titlePadding-left-$uuid',
          onChanged: (val) => onTitlePaddingChanged?.call(
            val,
            PaddingDestination.left,
          ),
        ),
      ),
      const SizedBox(height: 10),
      BuildSidebarOption(
        title: 'Right',
        rightWidget: BuildSlider(
          min: 0,
          max: 30,
          controllerTag: '$widgetTitle-titlePadding-right-$uuid',
          onChanged: (val) => onTitlePaddingChanged?.call(
            val,
            PaddingDestination.right,
          ),
        ),
      ),
    ],
  );
}
