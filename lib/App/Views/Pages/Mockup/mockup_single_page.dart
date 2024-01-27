import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/mockup_single_controller.dart';
import 'package:flutterpp/App/Models/gradient_model.dart';
import 'package:flutterpp/App/Models/template_config_model.dart';
import 'package:flutterpp/App/Views/Global/build_appbar.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/build_create_mockup_sidebar.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_device_card.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MockupSinglePage extends GetView<MockupSingleController> {
  const MockupSinglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MockupSingleController>(
      init: MockupSingleController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: BuildAppBar(
            title: 'Mockup',
            hasBackButton: true,
            onBack: () => Get.back(),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                BuildMockupSinglePageBuddy(controller: controller),
                BuildMockupSinglePageSidebar(controller: controller),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: ElevatedButton(
                    onPressed: () => controller.updateMockup(),
                    child: const Text('save'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class BuildMockupSinglePageSidebar extends StatelessWidget {
  const BuildMockupSinglePageSidebar({
    super.key,
    required this.controller,
  });

  final MockupSingleController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      child: BuildCreateMockupSidebar(
        mockupId: controller.mockup.id,
        isScreenshotSelected: controller.seletedItem.id != null,

        updateLayout: controller.updateLayout,
        layoutName: controller.seletedItem.type,

        // start background
        initialColor: controller.seletedItem.backgroundColor,
        onColorChangedCallback: (color) {
          controller.updateBackground(color: color);
        },
        onGradiantChangedCallback: (gradient) {
          controller.updateBackground(gradient: gradient);
        },
        onImageUpload: (image) {
          controller.updateBackground(image: image);
        },
        activeGradient: GradientModel(
          colors: controller.seletedItem.backgroundGradient == null
              ? ['#000000', '#000000']
              : controller.seletedItem.backgroundGradient!
                  .map(
                    (e) => ColorHelper.colorToHex(e),
                  )
                  .toList(),
          angle: controller.seletedItem.gradientAngle,
        ),
        // end background

        // start icon
        isIconToggled: controller.seletedItem.showLogo,
        onIconToggle: (value) => controller.onIconToggle(value),
        onIconUpload: (icon) => controller.updateLogo(logo: icon),
        initialAlignment: controller.seletedItem.logoAlignment,
        initialIconTopPadding: controller.seletedItem.logoPaddingTop,
        initialIconBottomPadding: controller.seletedItem.logoPaddingBottom,
        initialIconLeftPadding: controller.seletedItem.logoPaddingLeft,
        initialIconRightPadding: controller.seletedItem.logoPaddingRight,
        onIconAlignmentChanged: (alignment) {
          controller.updateLogoAlignment(alignment: alignment);
        },
        onIconPaddingChanged: (padding, destination) {
          controller.updateLogoPadding(
            padding: padding,
            destination: destination,
          );
        },
        // end icon

        // start title
        titleText: controller.seletedItem.title,
        titleFontFamily: controller.seletedItem.titleFontFamily,
        showTitle: controller.seletedItem.showTitle,
        titleAlignment: controller.seletedItem.titleAlignment,
        titleFontSize: controller.seletedItem.titleFontSize,
        titleLineHeight: controller.seletedItem.titleLineHeight,
        titleColor: controller.seletedItem.titleColor,
        titlePaddingTop: controller.seletedItem.titlePaddingTop,
        titlePaddingBottom: controller.seletedItem.titlePaddingBottom,
        titlePaddingLeft: controller.seletedItem.titlePaddingLeft,
        titlePaddingRight: controller.seletedItem.titlePaddingRight,
        onShowTitleChanged: controller.updateTitleVisibility,
        onTitleAlignmentChanged: controller.updateTitleAlignment,
        onTitleFontSizeChanged: controller.updateTitleFontSize,
        onTitleLineHeightChanged: controller.updateTitleLineHeight,
        onTitleColorChanged: controller.updateTitleColor,
        onTitlePaddingChanged: controller.updateTitlePadding,
        onTitleChanged: controller.updateTitle,
        onTitleFontFamilyChanged: controller.updateTitleFontFamily,
        // end title

        // start subtitle
        subtitleText: controller.seletedItem.subtitle,
        subtitleFontFamily: controller.seletedItem.subtitleFontFamily,
        showSubtitle: controller.seletedItem.showSubtitle,
        subtitleAlignment: controller.seletedItem.subtitleAlignment,
        subtitleFontSize: controller.seletedItem.subtitleFontSize,
        subtitleLineHeight: controller.seletedItem.subtitleLineHeight,
        subtitleColor: controller.seletedItem.subtitleColor,
        subtitlePaddingTop: controller.seletedItem.subtitlePaddingTop,
        subtitlePaddingBottom: controller.seletedItem.subtitlePaddingBottom,
        subtitlePaddingLeft: controller.seletedItem.subtitlePaddingLeft,
        subtitlePaddingRight: controller.seletedItem.subtitlePaddingRight,
        onShowSubtitleChanged: controller.updateSubtitleVisibility,
        onSubtitleAlignmentChanged: controller.updateSubtitleAlignment,
        onSubtitleFontSizeChanged: controller.updateSubtitleFontSize,
        onSubtitleLineHeightChanged: controller.updateSubtitleLineHeight,
        onSubtitleColorChanged: controller.updateSubtitleColor,
        onSubtitlePaddingChanged: controller.updateSubtitlePadding,
        onSubtitleChanged: controller.updateSubtitle,
        onSubtitleFontFamilyChanged: controller.updateSubtitleFontFamily,
        // end subtitle

        // start device
        showDevice: controller.seletedItem.showDevice,
        showSecondDevice: controller.seletedItem.showSecondDevice,
        showFrame: controller.seletedItem.showFrame,
        showSecondFrame: controller.seletedItem.showSecondFrame,
        firstInitalDeviceFrame: controller.seletedItem.firstDeviceFrame,
        secondInitalDeviceFrame: controller.seletedItem.secondDeviceFrame,
        showStroke: controller.seletedItem.showStroke,
        showSecondStroke: controller.seletedItem.showSecondStroke,
        strokeColor: controller.seletedItem.strokeColor,
        secondStrokeColor: controller.seletedItem.secondStrokeColor,
        strokeWidth: controller.seletedItem.strokeWidth,
        secondStrokeWidth: controller.seletedItem.secondStrokeWidth,
        shadowColor: controller.seletedItem.shadowColor,
        secondShadowColor: controller.seletedItem.secondShadowColor,
        shadowBlur: controller.seletedItem.shadowBlur,
        secondShadowBlur: controller.seletedItem.secondShadowBlur,
        shadowOffsetX: controller.seletedItem.shadowOffsetX,
        secondShadowOffsetX: controller.seletedItem.secondShadowOffsetX,
        shadowOffsetY: controller.seletedItem.shadowOffsetY,
        secondShadowOffsetY: controller.seletedItem.secondShadowOffsetY,
        rotate: controller.seletedItem.rotate,
        secondRotate: controller.seletedItem.secondRotate,
        firstDeviceVerticalPosition:
            controller.seletedItem.firstDevicePositionRightLeft,
        firstDeviceHorizontalPosition:
            controller.seletedItem.firstDevicePositionTopBottom,
        secondDeviceVerticalPosition:
            controller.seletedItem.secondDevicePositionRightLeft,
        secondDeviceHorizontalPosition:
            controller.seletedItem.secondDevicePositionTopBottom,
        scale: controller.seletedItem.scale,
        secondScale: controller.seletedItem.secondScale,
        updateDeviceScale: controller.updateDeviceScale,
        updateDeviceStrokeVisibility: controller.updateDeviceStrokeVisibility,
        updateShowDevice: controller.updateShowDevice,
        updateShowDeviceFrame: controller.updateShowDeviceFrame,
        onUpdateDevicePossition: controller.updateDevicePossition,
        updateDeviceRotate: controller.updateDeviceRotate,
        updateDeviceFullSize: controller.updateDeviceFullSize,
        updateDeviceFrame: controller.updateDeviceFrame,
        onDeviceImageUpload: controller.onDeviceImageUpload,
        updateStrokeColor: controller.updateDeviceStrokeColor,
        updateStrokeWidth: controller.updateDeviceStrokeWidth,
        updateShadowColor: controller.updateDeviceShadowColor,
        updateDeviceShadowBlur: controller.updateDeviceShadowBlur,
        updateDeviceShadowXOffset: controller.updateDeviceShadowXOffset,
        updateDeviceShadowYOffset: controller.updateDeviceShadowYOffset,
        updateDeviceShadowVisibility: controller.updateDeviceShadowVisibility,
        // end device
      ),
    );
  }
}

class BuildMockupSinglePageBuddy extends StatelessWidget {
  const BuildMockupSinglePageBuddy({
    super.key,
    required this.controller,
  });

  final MockupSingleController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.all(10.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 700,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: controller.mockup.jsonData!.length,
                          padding: EdgeInsets.only(
                            right: 2.sp,
                            left: 2.sp,
                            top: 2.sp,
                            bottom: 2.sp,
                          ),
                          itemBuilder: (_, int i) {
                            TemplateConfigModel config =
                                controller.mockup.jsonData![i];
                            return InkWell(
                              onTap: () => controller.updateSelectedItem(
                                config,
                              ),
                              child: BuildDeviceCard(
                                config: config,
                                onRemove: controller.deleteItem,
                                copyItemToAll: controller.copyItemToAll,
                                copyItem: controller.copyItem,
                                pasteItem: controller.pasteItem,
                                isSeleted:
                                    controller.seletedItem.id == config.id,
                              ),
                            );
                          },
                          separatorBuilder: (_, __) => SizedBox(
                            width: 1.sp,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => controller.addNewItem(),
                        child: Text('add new Screen'.capitalize!),
                      ),
                      SizedBox(width: 140.sp),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
