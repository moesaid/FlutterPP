import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterpp/Config/app_gradients.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:get/get.dart';

class BuildIconAndGradientsController extends GetxController {
  final _colors = <List<Color>>[].obs;
  List<List<Color>> get colors => _colors;

  final _svgs = <String>[].obs;
  List<String> get svgs => _svgs;

  final _selectedSVG = ''.obs;
  String get selectedSVG => _selectedSVG.value;

  final _selectedColors = <Color>[].obs;
  List<Color> get selectedColors => _selectedColors;

  final _oreginalSelectedColors = <String>[].obs;
  List<String> get oreginalSelectedColors => _oreginalSelectedColors;

  @override
  Future<void> onReady() async {
    await _listOFSVGs();
    _listOfColors();
    super.onReady();
  }

  // list of svg
  _listOFSVGs() async {
    final manifestJson = await DefaultAssetBundle.of(Get.context!)
        .loadString('AssetManifest.json');
    final allFiles = json
        .decode(manifestJson)
        .keys
        .where((String key) => key.startsWith('assets/svg'))
        .toList();

    // remover what not ends with .svg
    allFiles.removeWhere((element) => !element.endsWith('.svg'));

    // remove assets/svg/
    List svgs = allFiles.map((e) => e.replaceFirst('assets/svg/', '')).toList();

    // convert each item in the array to a string
    List<String> arr = svgs.map((e) => e.toString()).toList();

    // add to _svgs
    _svgs.addAll(arr);
    update();

    // set random svg
    onSVGChange(_svgs[Random().nextInt(_svgs.length)]);
  }

  // list of colors
  void _listOfColors() {
    var localColors = AppGradients.getRandomColors();
    _colors.addAll(localColors);
    update();

    onColorChange(localColors[Random().nextInt(localColors.length)]);
  }

  // on svg change
  void onSVGChange(String svg) {
    _selectedSVG.value = svg;
    update();
  }

  // on color change
  void onColorChange(List<Color> colors) {
    // from colors to hexcolor
    List<String> hexColors = colors
        .map(
          (e) => ColorHelper.colorToHex(e),
        )
        .toList();

    // set selected colors
    _selectedColors.value = colors;
    _oreginalSelectedColors.value = hexColors;
    update();
  }
}
