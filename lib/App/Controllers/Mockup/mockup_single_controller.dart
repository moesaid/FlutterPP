import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Enums/padding_destination_enum.dart';
import 'package:flutterpp/App/Enums/template_layout_enum.dart';
import 'package:flutterpp/App/Models/gradient_model.dart';
import 'package:flutterpp/App/Models/mockup_model.dart';
import 'package:flutterpp/App/Models/template_config_model.dart';
import 'package:flutterpp/App/Services/Mockups/mockup_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/template_layout_config.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class MockupSingleController extends GetxController {
  MockupServices mockupServices = MockupServices();

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _mockup = MockupModel().obs;
  MockupModel get mockup => _mockup.value;

  final _seletedItem = TemplateConfigModel().obs;
  TemplateConfigModel get seletedItem => _seletedItem.value;

  @override
  void onInit() {
    _getMockup();

    ever(_seletedItem, (_) {
      _updateMockupData();
    });

    super.onInit();
  }

  // get mockup
  void _getMockup() {
    _mockup.value = Get.arguments as MockupModel;
    _isLoading.value = false;
    update();
  }

  // update mockup data
  _updateMockupData() {
    List<TemplateConfigModel> jsonData = mockup.jsonData!;
    int index = jsonData.indexWhere((el) => el.id == _seletedItem.value.id);
    jsonData[index] = _seletedItem.value;
    _mockup.value = _mockup.value.copyWith(jsonData: jsonData);
  }

  // update mockup
  Future<void> updateMockup() async {
    await Get.showOverlay(
      asyncFunction: () async {
        await mockupServices.updateMockup(mockup: _mockup.value);
      },
      loadingWidget: const BuildOverlay(),
    );
  }

  // update selected item
  void updateSelectedItem(TemplateConfigModel item) {
    if (item.id == _seletedItem.value.id) return;
    _seletedItem.value = item;

    update();
  }

  // update background
  void updateBackground({
    Color? color,
    String? image,
    GradientModel? gradient,
  }) {
    _seletedItem.value = _seletedItem.value.copyWith(
      backgroundColor: color,
      backgroundImage: image,
      backgroundGradient: gradient == null ||
              gradient.colors == null ||
              gradient.colors!.isEmpty
          ? null
          : [
              ColorHelper.hexToColor(gradient.colors!.first),
              ColorHelper.hexToColor(gradient.colors!.last),
            ],
      gradientAngle: gradient?.angle,
    );
  }

  // update icon toggle
  onIconToggle(bool value) {
    _seletedItem.value = _seletedItem.value.copyWith(
      showLogo: value,
    );
  }

  // update logo
  updateLogo({required String logo}) {
    _seletedItem.value = _seletedItem.value.copyWith(
      logo: logo,
    );
  }

  // update logo alignment
  updateLogoAlignment({required MainAxisAlignment alignment}) {
    _seletedItem.value = _seletedItem.value.copyWith(
      logoAlignment: alignment,
    );
  }

  // update logo padding
  updateLogoPadding({
    required double padding,
    required PaddingDestination destination,
  }) {
    _seletedItem.value = _seletedItem.value.copyWith(
      logoPaddingBottom: destination == PaddingDestination.bottom
          ? padding
          : _seletedItem.value.logoPaddingBottom,
      logoPaddingTop: destination == PaddingDestination.top
          ? padding
          : _seletedItem.value.logoPaddingTop,
      logoPaddingLeft: destination == PaddingDestination.left
          ? padding
          : _seletedItem.value.logoPaddingLeft,
      logoPaddingRight: destination == PaddingDestination.right
          ? padding
          : _seletedItem.value.logoPaddingRight,
    );
  }

  // update title
  updateTitle(String title) {
    _seletedItem.value = _seletedItem.value.copyWith(
      title: title,
    );
  }

  // update title visibility
  updateTitleVisibility(bool value) {
    _seletedItem.value = _seletedItem.value.copyWith(
      showTitle: value,
    );
  }

  // update title alignment
  updateTitleAlignment(MainAxisAlignment alignment) {
    _seletedItem.value = _seletedItem.value.copyWith(
      titleAlignment: alignment,
    );
  }

  void updateTitleFontSize(double fontSize) {
    _seletedItem.value = _seletedItem.value.copyWith(
      titleFontSize: fontSize,
    );
  }

  void updateTitleLineHeight(double lineHeight) {
    _seletedItem.value = _seletedItem.value.copyWith(
      titleLineHeight: lineHeight,
    );
  }

  void updateTitleColor(Color color) {
    _seletedItem.value = _seletedItem.value.copyWith(
      titleColor: color,
    );
  }

  void updateTitlePadding(
    double padding,
    PaddingDestination destination,
  ) {
    _seletedItem.value = _seletedItem.value.copyWith(
      titlePaddingBottom: destination == PaddingDestination.bottom
          ? padding
          : _seletedItem.value.titlePaddingBottom,
      titlePaddingTop: destination == PaddingDestination.top
          ? padding
          : _seletedItem.value.titlePaddingTop,
      titlePaddingLeft: destination == PaddingDestination.left
          ? padding
          : _seletedItem.value.titlePaddingLeft,
      titlePaddingRight: destination == PaddingDestination.right
          ? padding
          : _seletedItem.value.titlePaddingRight,
    );
  }

  // update Subtitle
  updateSubtitle(String title) {
    _seletedItem.value = _seletedItem.value.copyWith(
      subtitle: title,
    );
  }

  // update Subtitle visibility
  updateSubtitleVisibility(bool value) {
    _seletedItem.value = _seletedItem.value.copyWith(
      showSubtitle: value,
    );
  }

  // update Subtitle alignment
  updateSubtitleAlignment(MainAxisAlignment alignment) {
    _seletedItem.value = _seletedItem.value.copyWith(
      subtitleAlignment: alignment,
    );
  }

  void updateSubtitleFontSize(double fontSize) {
    _seletedItem.value = _seletedItem.value.copyWith(
      subtitleFontSize: fontSize,
    );
  }

  void updateSubtitleLineHeight(double lineHeight) {
    _seletedItem.value = _seletedItem.value.copyWith(
      subtitleLineHeight: lineHeight,
    );
  }

  void updateSubtitleColor(Color color) {
    _seletedItem.value = _seletedItem.value.copyWith(
      subtitleColor: color,
    );
  }

  void updateSubtitlePadding(
    double padding,
    PaddingDestination destination,
  ) {
    _seletedItem.value = _seletedItem.value.copyWith(
      subtitlePaddingBottom: destination == PaddingDestination.bottom
          ? padding
          : _seletedItem.value.subtitlePaddingBottom,
      subtitlePaddingTop: destination == PaddingDestination.top
          ? padding
          : _seletedItem.value.subtitlePaddingTop,
      subtitlePaddingLeft: destination == PaddingDestination.left
          ? padding
          : _seletedItem.value.subtitlePaddingLeft,
      subtitlePaddingRight: destination == PaddingDestination.right
          ? padding
          : _seletedItem.value.subtitlePaddingRight,
    );
  }

  // update title font family
  void updateTitleFontFamily(String val) {
    _seletedItem.value = _seletedItem.value.copyWith(
      titleFontFamily: val,
    );
  }

  // update subtitle font family
  void updateSubtitleFontFamily(String val) {
    _seletedItem.value = _seletedItem.value.copyWith(
      subtitleFontFamily: val,
    );
  }

  //# device methods #//

  // update first device frame
  void updateDeviceFrame(DeviceInfo frame, {bool? isSecondDevice}) {
    if (isSecondDevice != null && isSecondDevice) {
      _seletedItem.value = _seletedItem.value.copyWith(
        secondDeviceFrame: frame.name,
      );
      return;
    }

    _seletedItem.value = _seletedItem.value.copyWith(
      firstDeviceFrame: frame.name,
    );
  }

  // update first device possition
  void updateDevicePossition({
    double? horizontalPosition,
    double? verticalPosition,
    double? secondHorizontalPosition,
    double? secondVerticalPosition,
  }) {
    if (horizontalPosition != null) {
      _seletedItem.value = _seletedItem.value.copyWith(
        firstDevicePositionTopBottom: horizontalPosition,
      );
    }
    if (verticalPosition != null) {
      _seletedItem.value = _seletedItem.value.copyWith(
        firstDevicePositionRightLeft: verticalPosition,
      );
    }
    if (secondHorizontalPosition != null) {
      _seletedItem.value = _seletedItem.value.copyWith(
        secondDevicePositionTopBottom: secondHorizontalPosition,
      );
    }
    if (secondVerticalPosition != null) {
      _seletedItem.value = _seletedItem.value.copyWith(
        secondDevicePositionRightLeft: secondVerticalPosition,
      );
    }
  }

  // update first device rotate
  void updateDeviceRotate(double rotate, {bool? isSecondDevice}) {
    print(isSecondDevice);
    if (isSecondDevice != null && isSecondDevice) {
      _seletedItem.value = _seletedItem.value.copyWith(
        secondRotate: rotate,
      );
      return;
    }

    _seletedItem.value = _seletedItem.value.copyWith(
      rotate: rotate,
    );
  }

  // update device full size
  void updateDeviceFullSize(bool value, {bool? isSecondDevice}) {
    if (isSecondDevice != null && isSecondDevice) {
      _seletedItem.value = _seletedItem.value.copyWith(
        secondDeviceFullSize: value,
      );
      return;
    }

    _seletedItem.value = _seletedItem.value.copyWith(
      deviceFullSize: value,
    );
  }

  // update stroke visibility
  void updateDeviceStrokeVisibility(bool value, {bool? isSecondDevice}) {
    if (isSecondDevice != null && isSecondDevice) {
      _seletedItem.value = _seletedItem.value.copyWith(
        showSecondStroke: value,
      );
      return;
    }

    _seletedItem.value = _seletedItem.value.copyWith(
      showStroke: value,
    );
  }

  // update first stroke color
  void updateDeviceStrokeColor(Color color, {bool? isSecondDevice}) {
    if (isSecondDevice != null && isSecondDevice) {
      _seletedItem.value = _seletedItem.value.copyWith(
        secondStrokeColor: color,
      );
      return;
    }

    _seletedItem.value = _seletedItem.value.copyWith(
      strokeColor: color,
    );
  }

  // update first stroke width
  void updateDeviceStrokeWidth(double width, {bool? isSecondDevice}) {
    if (isSecondDevice != null && isSecondDevice) {
      _seletedItem.value = _seletedItem.value.copyWith(
        secondStrokeWidth: width,
      );
      return;
    }

    _seletedItem.value = _seletedItem.value.copyWith(
      strokeWidth: width,
    );
  }

  // update first shadow color
  void updateDeviceShadowColor(Color color, {bool? isSecondDevice}) {
    if (isSecondDevice != null && isSecondDevice) {
      _seletedItem.value = _seletedItem.value.copyWith(
        secondShadowColor: color,
      );
      return;
    }

    _seletedItem.value = _seletedItem.value.copyWith(
      shadowColor: color,
    );
  }

  // update first shadow blur
  void updateDeviceShadowBlur(double blur, {bool? isSecondDevice}) {
    if (isSecondDevice != null && isSecondDevice) {
      _seletedItem.value = _seletedItem.value.copyWith(
        secondShadowBlur: blur,
      );
      return;
    }

    _seletedItem.value = _seletedItem.value.copyWith(
      shadowBlur: blur,
    );
  }

  // update first shadow x offset
  void updateDeviceShadowXOffset(double xOffset, {bool? isSecondDevice}) {
    if (isSecondDevice != null && isSecondDevice) {
      _seletedItem.value = _seletedItem.value.copyWith(
        secondShadowOffsetX: xOffset,
      );
      return;
    }
    _seletedItem.value = _seletedItem.value.copyWith(
      shadowOffsetX: xOffset,
    );
  }

  // update first shadow y offset
  void updateDeviceShadowYOffset(double yOffset, {bool? isSecondDevice}) {
    if (isSecondDevice != null && isSecondDevice) {
      _seletedItem.value = _seletedItem.value.copyWith(
        secondShadowOffsetY: yOffset,
      );
      return;
    }

    _seletedItem.value = _seletedItem.value.copyWith(
      shadowOffsetY: yOffset,
    );
  }

  void onDeviceImageUpload(String image, {bool? isSecondDevice}) {
    if (isSecondDevice != null && isSecondDevice) {
      _seletedItem.value = _seletedItem.value.copyWith(
        secondImage: image,
      );
      return;
    }

    _seletedItem.value = _seletedItem.value.copyWith(
      image: image,
    );
  }

  void updateShowDevice(bool value, {bool? isSecondDevice}) {
    if (isSecondDevice != null && isSecondDevice) {
      _seletedItem.value = _seletedItem.value.copyWith(
        showSecondDevice: value,
      );
      return;
    }

    _seletedItem.value = _seletedItem.value.copyWith(
      showDevice: value,
    );
  }

  void updateShowDeviceFrame(bool value, {bool? isSecondDevice}) {
    if (isSecondDevice != null && isSecondDevice) {
      _seletedItem.value = _seletedItem.value.copyWith(
        showSecondFrame: value,
      );
      return;
    }

    _seletedItem.value = _seletedItem.value.copyWith(
      showFrame: value,
    );
  }

  void updateDeviceScale(double scale, {bool? isSecondDevice}) {
    if (isSecondDevice != null && isSecondDevice) {
      _seletedItem.value = _seletedItem.value.copyWith(
        secondScale: scale,
      );
      return;
    }

    _seletedItem.value = _seletedItem.value.copyWith(
      scale: scale,
    );
  }

  void updateLayout(TemplateConfigModel layout) {
    // safe replcae and assign old uuid
    layout = layout.copyWith(id: _seletedItem.value.id);

    // update layout
    _seletedItem.value = layout;
  }

  void addNewItem() {
    // create new item
    TemplateConfigModel newItem = TemplateConfigModel.fromJson(
      TemplateLayoutConfig().getLayoutConfig(TemplateLayoutEnum.titleUp),
    )..id = const Uuid().v4();

    // add new item to mockup
    _mockup.value = _mockup.value.copyWith(
      jsonData: [..._mockup.value.jsonData!, newItem],
    );

    // update selected item
    _seletedItem.value = newItem;
    update();
  }
}
