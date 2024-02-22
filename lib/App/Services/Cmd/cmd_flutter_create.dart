import 'dart:io';

import 'package:flutterpp/App/Providers/Cmd/cmd_flutter_provider.dart';
import 'package:flutterpp/Config/app_print.dart';

class CmdFlutterCreate {
  final String _projectPath;
  final String _projectName;
  final CmdFlutterProvider _cmdF = CmdFlutterProvider();

  CmdFlutterCreate(this._projectPath, this._projectName);

  Future<void> run() async {
    ProcessResult? res = await _cmdF.runFlutterCommand(
      _projectPath,
      ['create', _projectName],
    );

    AppPrint.print({
      'stdout': res?.stdout,
      'stderr': res?.stderr,
      'exitCode': res?.exitCode,
    });
  }
}
