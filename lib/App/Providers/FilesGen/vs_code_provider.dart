import 'dart:io';

import 'package:flutterpp/App/Services/Cmd/cmd_read_create_dir_services.dart';

class VsCodeProvider {
  final CmdReadCreateDirServices _cmdRCD = CmdReadCreateDirServices();

  // create vs code settings
  Future<void> vsCodeSettingsGen(String path) async {
    // create .vscode directory
    await _cmdRCD.createDirectory('$path/.vscode');

    // remove settings.json file if exists
    if (File('$path/.vscode/settings.json').existsSync()) {
      File('$path/.vscode/settings.json').deleteSync();
    }

    // content
    String content = '''{
      "editor.codeActionsOnSave": {
        "source.fixAll": "explicit",
        "source.organizeImports": "explicit"
      },
      "editor.formatOnSave": true
    }''';

    // create file
    File file = File('$path/.vscode/settings.json');

    // write to file
    file.writeAsStringSync(content);
  }
}
