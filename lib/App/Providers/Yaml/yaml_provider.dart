import 'dart:convert';
import 'dart:io';

import 'package:flutterpp/App/Models/pubspec_model.dart';
import 'package:flutterpp/Config/app_print.dart';
import 'package:yaml/yaml.dart';

class YamlProvider {
  // read yaml file from path
  Future<PubspecModel?> readYaml(String path) async {
    try {
      var file = File(path);
      var yamlString = await file.readAsString();
      var doc = loadYaml(yamlString);
      return PubspecModel.fromJson(json.decode(json.encode(doc)));
    } catch (e) {
      AppPrint.print('Error reading yaml file: $e');
      return null;
    }
  }

  // get app name from yaml
  Future<String> getNameSpace(String path) async {
    try {
      var yaml = await readYaml(path);
      return yaml?.name ?? '';
    } catch (e) {
      AppPrint.print('Error getting app name from yaml: $e');
      return '';
    }
  }
}
