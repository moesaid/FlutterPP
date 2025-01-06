import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/gradient_model.dart';
import 'package:flutterpp/App/Views/Global/build_preeset_gradient_list.dart';
import 'package:flutterpp/App/Views/Global/build_slider.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_pick_color.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_sidebar_option.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:flutterpp/Helpers/text_helper.dart';
import 'package:get/get.dart';

class BuildColorPresetGradient extends StatelessWidget {
  final String? name;
  final GradientModel? gradient;
  final Function(GradientModel) callback;
  final Function(Color, int) onSingleColorUpdate;
  final void Function(double angle)? angleCallback;
  const BuildColorPresetGradient({
    super.key,
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
                color: Get.theme.primaryColor.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
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
