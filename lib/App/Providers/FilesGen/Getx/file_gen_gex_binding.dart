import 'dart:io';

import 'package:flutterpp/Helpers/text_helper.dart';

class FileGenGexBinding {
  updateBindingFile(
    String nameSpace,
    String path,
    String caseName,
  ) {
    // Define the path to your binding file
    String filePath = path;

    // Read the existing content of the file
    File bindingFile = File(filePath);
    String existingContent = bindingFile.readAsStringSync();

    // new imports
    String imports =
        ''' import 'package:$nameSpace/App/Controllers/${caseName.toFolderName()}/${caseName.toFolderName()}_controller.dart';''';

    // new lazy put
    String lazyPut =
        '''\n  ..lazyPut<${caseName.toPascalCase()}Controller>(() => ${caseName.toPascalCase()}Controller())''';

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
