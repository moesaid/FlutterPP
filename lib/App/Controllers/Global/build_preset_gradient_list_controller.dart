import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutterpp/App/Models/gradient_model.dart';
import 'package:flutterpp/App/Views/Global/build_snackbar.dart';
import 'package:get/get.dart';

class BuildPresetGradientListController extends GetxController {
  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _gradientsList = <GradientModel>[];
  List<GradientModel> get gradientsList => _gradientsList;

  @override
  Future<void> onReady() async {
    await _populateGradients();
    super.onReady();
  }

  // populate gradients
  _populateGradients() async {
    try {
      // Path to the local JSON file
      String filePath = 'assets/jsons/gradients.json';
      // Read the JSON file
      String jsonContent = await rootBundle.loadString(filePath);

      // Parse the JSON data
      var jsonData = await json.decode(jsonContent);

      // convert json to list of gradient model
      _gradientsList.addAll(
        jsonData.map<GradientModel>((json) => GradientModel.fromJson(json)),
      );

      _isLoading.value = false;
      update();
    } catch (e) {
      BuildSnackBar(title: 'error', message: e.toString()).error();
    }
  }
}
