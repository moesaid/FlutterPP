import 'dart:io';

import 'package:flutterpp/Helpers/text_helper.dart';

class FileGenGexBindingProvider {
  Future<void> updateBindingFile(
    String nameSpace,
    String path,
    String caseName,
    bool isCrud,
  ) async {
    // Read the existing content of the file
    File bindingFile = File(path);
    String existingContent = bindingFile.readAsStringSync();

    // new imports
    String imports;
    if (isCrud) {
      imports =
          ''' import 'package:$nameSpace/App/Controllers/${caseName.toFolderName()}/${caseName.toSnakeCase()}_index_controller.dart';\nimport 'package:$nameSpace/App/Controllers/${caseName.toFolderName()}/${caseName.toSnakeCase()}_single_controller.dart';\nimport 'package:$nameSpace/App/Controllers/${caseName.toFolderName()}/${caseName.toSnakeCase()}_create_controller.dart';\nimport 'package:$nameSpace/App/Controllers/${caseName.toFolderName()}/${caseName.toSnakeCase()}_edit_controller.dart';''';
    } else {
      imports =
          ''' import 'package:$nameSpace/App/Controllers/${caseName.toFolderName()}/${caseName.toSnakeCase()}_controller.dart';''';
    }

    // new lazy put
    String lazyPut;
    if (isCrud) {
      lazyPut =
          '''\n  ..lazyPut<${caseName.toPascalCase()}IndexController>(() => ${caseName.toPascalCase()}IndexController())\n  ..lazyPut<${caseName.toPascalCase()}SingleController>(() => ${caseName.toPascalCase()}SingleController())\n  ..lazyPut<${caseName.toPascalCase()}CreateController>(() => ${caseName.toPascalCase()}CreateController())\n  ..lazyPut<${caseName.toPascalCase()}EditController>(() => ${caseName.toPascalCase()}EditController())''';
    } else {
      lazyPut =
          '''\n  ..lazyPut<${caseName.toPascalCase()}Controller>(() => ${caseName.toPascalCase()}Controller())''';
    }

    // write import to the top of the file
    String newContent = existingContent.replaceFirst(
      'import \'package:get/get.dart\';',
      'import \'package:get/get.dart\';$imports',
    );

    // write lazy put after Get.. in the file
    newContent = newContent.replaceFirst(
      'Get',
      'Get$lazyPut',
    );

    // write to file
    bindingFile.writeAsStringSync(newContent);
  }
}
