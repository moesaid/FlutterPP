import 'dart:io';

import 'package:flutterpp/App/Services/Cmd/cmd_read_create_dir_services.dart';
import 'package:flutterpp/Config/app_print.dart';

class VsCodeProvider {
  final CmdReadCreateDirServices _cmdRCD = CmdReadCreateDirServices();

  // create vs code settings
  Future<void> vsCodeSettingsGen(String path) async {
    // create .vscode directory
    await _cmdRCD.createDirectory('$path/.vscode');

    // content
    String content = '''{
      "editor.codeActionsOnSave": {
        "source.fixAll": "explicit",
        "source.organizeImports": "explicit"
      },
      "editor.formatOnSave": true
    }''';

    // remove settings.json file if exists
    try {
      if (await File('$path/.vscode/settings.json').exists()) {
        File('$path/.vscode/settings.json').deleteSync();
      }
    } catch (e) {
      AppPrint.printError('Error deleting file: $e');
    }

    // create file
    File file = File('$path/.vscode/settings.json');

    // write to file
    file.writeAsStringSync(content);
  }
}
