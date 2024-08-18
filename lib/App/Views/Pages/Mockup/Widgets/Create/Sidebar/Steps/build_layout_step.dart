import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/Micro/build_layout_option_controller.dart';
import 'package:flutterpp/App/Enums/template_layout_enum.dart';
import 'package:flutterpp/App/Models/template_config_model.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/template_layout_config.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_device_card.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

ExpansionTileItem buildLayoutStep({
  required BuildContext context,
  void Function(TemplateConfigModel)? onLayoutChanged,
  String? controllerTag,
  String? layoutName,
}) {
  return ExpansionTileItem(
    title: const Text('Layout'),
    leading: const Icon(Icons.crop_free),
    collapsedBorderColor: Colors.transparent,
    collapsedTextColor: Colors.grey.withOpacity(0.8),
    collapsedIconColor: Colors.grey.withOpacity(0.8),
    expendedBorderColor: Colors.grey.withOpacity(0.2),
    textColor: Colors.white,
    iconColor: Colors.white,
    children: [
      GetBuilder<BuildLayoutOptionController>(
        init: BuildLayoutOptionController(),
        builder: (_) {
          return InkWell(
            onTap: () {
              aweSideSheet(
                context: context,
                sheetPosition: SheetPosition.right,
                footer: const SizedBox.shrink(),
                header: Padding(
                  padding: EdgeInsets.all(4.spa),
                  child: const Row(
                    children: [
                      Spacer(),
                      Text(
                        'Screen Layouts',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      CloseButton(),
                    ],
                  ),
                ),
                sheetWidth: 100.h,
                body: Obx(
                  () => BuildScreenLayoutsWidget(
                    activeLayout: _.activeLayout,
                    onEnter: _.onEnter,
                    onExit: _.onExit,
                    onLayoutChanged: onLayoutChanged,
                  ),
                ),
              );
            },
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
              child: Row(
                children: [
                  Expanded(child: Text(layoutName ?? 'Layout name')),
                  const Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ],
  );
}

class BuildScreenLayoutsWidget extends StatelessWidget {
  final Function(TemplateConfigModel)? onLayoutChanged;
  final Function(String)? onEnter, onExit;
  final String? activeLayout;

  const BuildScreenLayoutsWidget({
    super.key,
    this.onLayoutChanged,
    this.onEnter,
    this.onExit,
    this.activeLayout,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.spa),
      child: GridView.builder(
        padding: EdgeInsets.only(top: 5.spa),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing: 1.spa,
          mainAxisSpacing: 1.spa,
          mainAxisExtent: 650,
          maxCrossAxisExtent: 350,
        ),
        itemCount: TemplateLayoutEnum.all.length,
        itemBuilder: (BuildContext context, int index) {
          TemplateConfigModel config = TemplateConfigModel.fromJson(
            TemplateLayoutConfig().getLayoutConfig(
              TemplateLayoutEnum.all[index],
            ),
          );

          return InkWell(
            onTap: () {
              onLayoutChanged?.call(config);
              Get.back();
            },
            child: MouseRegion(
              onEnter: (e) => onEnter?.call(config.type!),
              onExit: (e) => onExit?.call(config.type!),
              child: AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: activeLayout == config.type ? 1.01 : 1,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: activeLayout == config.type
                          ? Get.theme.colorScheme.secondary
                          : Colors.transparent,
                      width: 4,
                    ),
                  ),
                  child: BuildDeviceBody(config: config),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
