import 'dart:io';

import 'package:flutterpp/Helpers/text_helper.dart';

class GoRouterGenProvider {
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
      static const ${caseName.toUpperCase()}_INDEX = '/$caseName';
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
    String imports = '';

    if (isCrud == true) {
      imports = '''
        import 'package:$nameSpace/App/Views/Pages/${caseName.toFolderName()}/${caseName.toSnakeCase()}_index_page.dart';
        import 'package:$nameSpace/App/Views/Pages/${caseName.toFolderName()}/${caseName.toSnakeCase()}_single_page.dart';
        import 'package:$nameSpace/App/Views/Pages/${caseName.toFolderName()}/${caseName.toSnakeCase()}_create_page.dart';
        import 'package:$nameSpace/App/Views/Pages/${caseName.toFolderName()}/${caseName.toSnakeCase()}_edit_page.dart';
      ''';
    } else {
      imports = '''
        import 'package:google/App/Views/Pages/Profile/profile_page.dart';
      ''';
    }

    // new content
    String content = '';

    // if is crud
    if (isCrud == true) {
      content = '''
      // start ${caseName.toPascalCase()} pages
      GoRoute(
        path: AppRoutes.${caseName.toUpperCase()}_INDEX,
        builder: (context, state) => const ${'${caseName.toPascalCase()}IndexPage'}(),
      ),
      GoRoute(
        path: AppRoutes.${caseName.toUpperCase()}_SINGLE,
        builder: (context, state) => const ${'${caseName.toPascalCase()}SinglePage'}(),
      ),
      GoRoute(
        path: AppRoutes.${caseName.toUpperCase()}_CREATE,
        builder: (context, state) => const ${'${caseName.toPascalCase()}CreatePage'}(),
      ),
      GoRoute(
        path: AppRoutes.${caseName.toUpperCase()}_EDIT,
        builder: (context, state) => const ${'${caseName.toPascalCase()}EditPage'}(),
      ),
      // end ${caseName.toPascalCase()} pages
      ''';
    } else {
      content = '''
      GoRoute(
        path: AppRoutes.${caseName.toUpperCase()},
        builder: (context, state) => const ${'${caseName.toPascalCase()}Page'}(),
      ),
      ''';
    }

    // write import to the top of the file
    String newContent = existingContent.replaceFirst(
      'import \'package:go_router/go_router.dart\';',
      'import \'package:go_router/go_router.dart\';\n$imports',
    );

    // write content to the bottom of the file
    newContent = newContent.replaceFirst(
      '],',
      '$content],',
    );

    // write to file
    bindingFile.writeAsStringSync(newContent);
  }
}
