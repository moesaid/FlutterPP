import 'package:flutter/material.dart';
import 'package:flutterpp/App/Enums/padding_destination_enum.dart';
import 'package:flutterpp/App/Models/gradient_model.dart';
import 'package:flutterpp/App/Models/mockup_model.dart';
import 'package:flutterpp/App/Models/template_config_model.dart';
import 'package:flutterpp/App/Services/Mockups/mockup_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:get/get.dart';

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

  //# update first device #//
  // update first device image
  updateFirstDeviceImage(String image) {
    _seletedItem.value = _seletedItem.value.copyWith(
      image: image,
    );
  }

  // update first device frame
  updateFirstDeviceFrame(String frame) {
    _seletedItem.value = _seletedItem.value.copyWith(
        // frame: frame,
        );
  }

  // update first device possition
  void onUpdateDevicePossition({
    double? firstDevicePositionTopBottom,
    double? firstDevicePositionRightLeft,
    double? secondDevicePositionTopBottom,
    double? secondDevicePositionRightLeft,
  }) {
    if (firstDevicePositionTopBottom != null) {
      _seletedItem.value = _seletedItem.value.copyWith(
        firstDevicePositionTopBottom: firstDevicePositionTopBottom,
      );
    }
    if (firstDevicePositionRightLeft != null) {
      _seletedItem.value = _seletedItem.value.copyWith(
        firstDevicePositionRightLeft: firstDevicePositionRightLeft,
      );
    }
    if (secondDevicePositionTopBottom != null) {
      _seletedItem.value = _seletedItem.value.copyWith(
        secondDevicePositionTopBottom: secondDevicePositionTopBottom,
      );
    }
    if (secondDevicePositionRightLeft != null) {
      _seletedItem.value = _seletedItem.value.copyWith(
        secondDevicePositionRightLeft: secondDevicePositionRightLeft,
      );
    }
  }

  // update first device rotate
  updateFirstDeviceRotate(double rotate) {
    _seletedItem.value = _seletedItem.value.copyWith(
      rotate: rotate,
    );
  }

  // update first device full size
  updateFirstDeviceFullSize(bool value) {
    _seletedItem.value = _seletedItem.value.copyWith(
      deviceFullSize: value,
    );
  }

  // update first stroke color
  updateFirstDeviceStrokeColor(Color color) {
    _seletedItem.value = _seletedItem.value.copyWith(
        // strokeColor: color,
        );
  }

  // update first stroke width
  updateFirstDeviceStrokeWidth(double width) {
    _seletedItem.value = _seletedItem.value.copyWith(
        // strokeWidth: width,
        );
  }

  // update first shadow color
  updateFirstDeviceShadowColor(Color color) {
    _seletedItem.value = _seletedItem.value.copyWith(
        // shadowColor: color,
        );
  }

  // update first shadow blur
  updateFirstDeviceShadowBlur(double blur) {
    _seletedItem.value = _seletedItem.value.copyWith(
        // shadowBlur: blur,
        );
  }

  // update first shadow x offset
  updateFirstDeviceShadowXOffset(double offset) {
    _seletedItem.value = _seletedItem.value.copyWith(
        // shadowXOffset: offset,
        );
  }

  // update first shadow y offset
  updateFirstDeviceShadowYOffset(double offset) {
    _seletedItem.value = _seletedItem.value.copyWith(
        // shadowYOffset: offset,
        );
  }

  void onDeviceImageUpload(String image) {
    _seletedItem.value = _seletedItem.value.copyWith(
      image: image,
    );
  }

  void onSecondDeviceImageUpload(String image) {
    _seletedItem.value = _seletedItem.value.copyWith(
      secondImage: image,
    );
  }
}
