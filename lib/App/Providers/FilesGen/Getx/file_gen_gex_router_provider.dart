import 'dart:io';

import 'package:flutterpp/Helpers/text_helper.dart';

class FileGenGetxRouterProvider {
  // update AppRoutes
  Future<void> updateAppRoutes(
    String nameSpace,
    String path,
    String caseName, {
    bool? isCrud = false,
  }) async {
    // Read the existing content of the file
    File bindingFile = File(path);
    String existingContent = bindingFile.readAsStringSync();

    // new content
    late String content;

    // if is crud
    if (isCrud == true) {
      content = '''
      // start ${caseName.toPascalCase()} routes
      static const ${caseName.toUpperCase()} = '/$caseName';
      static const ${caseName.toUpperCase()}_SINGLE = '/$caseName/single';
      static const ${caseName.toUpperCase()}_CREATE = '/$caseName/create';
      static const ${caseName.toUpperCase()}_EDIT = '/$caseName/edit';
      // end ${caseName.toPascalCase()} routes
      ''';
    } else {
      content = '''
      static const ${caseName.toUpperCase()} = '/$caseName';
      ''';
    }

    // write to file
    bindingFile.writeAsStringSync(
      existingContent.replaceFirst(
        '}',
        '$content}',
      ),
    );
  }

  // update AppPages
  Future<void> updateAppPages(
    String nameSpace,
    String path,
    String caseName, {
    bool? isCrud = false,
  }) async {
    // Read the existing content of the file
    File bindingFile = File(path);
    String existingContent = bindingFile.readAsStringSync();

    // new imports
    late String imports;

    if (isCrud == true) {
      imports = '''
        import 'package:$nameSpace/App/Views/Pages/${caseName.toFolderName()}/${caseName.toPascalCase()}_page.dart';
        import 'package:$nameSpace/App/Views/Pages/${caseName.toFolderName()}/${caseName.toPascalCase()}_single_page.dart';
        import 'package:$nameSpace/App/Views/Pages/${caseName.toFolderName()}/${caseName.toPascalCase()}_create_page.dart';
        import 'package:$nameSpace/App/Views/Pages/${caseName.toFolderName()}/${caseName.toPascalCase()}_edit_page.dart';
      ''';
    } else {
      imports = '''
        import 'package:$nameSpace/App/Views/Pages/${caseName.toFolderName()}/${caseName.toPascalCase()}_page.dart';
      ''';
    }

    // new content
    late String content;

    // if is crud
    if (isCrud == true) {
      content = '''
      // start ${caseName.toPascalCase()} pages
      GetPage(
        name: AppRoutes.${caseName.toUpperCase()},
        page: () => const ${'${caseName.toPascalCase()}Page'}(),
      ),
      GetPage(
        name: AppRoutes.${caseName.toUpperCase()}_SINGLE,
        page: () => const ${'${caseName.toPascalCase()}SinglePage'}(),
      ),
      GetPage(
        name: AppRoutes.${caseName.toUpperCase()}_CREATE,
        page: () => const ${'${caseName.toPascalCase()}CreatePage'}(),
      ),
      GetPage(
        name: AppRoutes.${caseName.toUpperCase()}_EDIT,
        page: () => const ${'${caseName.toPascalCase()}EditPage'}(),
      ),
      // end ${caseName.toPascalCase()} pages
      ''';
    } else {
      content = '''
      GetPage(
        name: AppRoutes.${caseName.toUpperCase()},
        page: () => const ${caseName.toPascalCase()}Page(),
      ),
      ''';
    }

    // write import to the top of the file
    String newContent = existingContent.replaceFirst(
      'import \'package:get/get.dart\';',
      'import \'package:get/get.dart\';$imports',
    );

    // write page after last page in the file
    newContent = newContent.replaceFirst(
      '];',
      '$content];',
    );

    // write to file
    bindingFile.writeAsStringSync(newContent);
  }
}
