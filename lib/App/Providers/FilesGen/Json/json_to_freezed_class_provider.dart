import 'dart:io';

import 'package:flutterpp/App/Models/model_config_model.dart';
import 'package:flutterpp/App/Providers/Yaml/yaml_provider.dart';
import 'package:flutterpp/Helpers/text_helper.dart';

class JsonToFreezedClassProvider {
  Future<void> generateFreezedClass(
    String path,
    ModelConfigModel modelConfig,
  ) async {
    // name space
    final String nameSpace =
        await YamlProvider().getNameSpace('$path/pubspec.yaml');

    // name of the class
    final String name = '${modelConfig.modelName?.toLowerCase()}_model';
    final StringBuffer classBuffer = StringBuffer();

    // delete file if exists
    final isFile = File('$path/lib/App/Models/$name.dart');
    if (isFile.existsSync()) {
      isFile.deleteSync();
    }

    // list of properties with no relation
    final List<Properties>? properties =
        modelConfig.properties?.where((el) => el.relationName == null).toList();

    // list of properties with relation
    final List<Properties>? relationProperties =
        modelConfig.properties?.where((el) => el.relationName != null).toList();

    // Import statements
    classBuffer.writeln(
        "import 'package:freezed_annotation/freezed_annotation.dart';");

    // Import statements for relations if any
    if (modelConfig.relations != null) {
      for (final item in modelConfig.relations!) {
        classBuffer.writeln(
            "import 'package:$nameSpace/App/Models/${item.name?.toSnakeCase()}_model.dart';");
      }
    }

    // Part directives
    classBuffer.writeln("part 'freezed/$name.freezed.dart';");
    classBuffer.writeln("part 'freezed/$name.g.dart';");

    // Freezed annotation
    classBuffer.writeln("@Freezed()");

    // Class declaration
    classBuffer.writeln(
        "class ${name.toPascalCase()} with _\$${name.toPascalCase()} {");

    // Constructor
    classBuffer.writeln("  const factory ${name.toPascalCase()}({");

    // Properties with no relation
    if (properties != null && properties.isNotEmpty) {
      for (final item in properties) {
        classBuffer.writeln(
            "    required ${item.type?.type} ${item.name?.toCamelCase()},");
      }
    }

    // Properties with relation
    if (relationProperties != null && relationProperties.isNotEmpty) {
      classBuffer.writeln("    // Relations");

      for (final item in relationProperties) {
        var relationName = '';
        if (item.type == PropertieType.hasOne) {
          relationName = '${item.relationName!.toPascalCase()}Model';
        }
        if (item.type == PropertieType.hasMany) {
          relationName = 'List<${item.relationName!.toPascalCase()}Model>';
        }

        classBuffer
            .writeln("    required $relationName ${item.name?.toCamelCase()},");
      }
    }

    classBuffer.writeln("  }) = _${name.toPascalCase()};");

    // FromJson method
    classBuffer.writeln(
        "  factory ${name.toPascalCase()}.fromJson(Map<String, Object?> json) =>");
    classBuffer.writeln("      _\$${name.toPascalCase()}FromJson(json);");

    // Close class
    classBuffer.writeln("}");

    // Write to a file
    final file = File('$path/lib/App/Models/$name.dart');

    file.writeAsStringSync(classBuffer.toString());
  }
}
