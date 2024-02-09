import 'dart:io';

import 'package:process_run/process_run.dart';

class CmdFlutterProvider {
  // run flutter command
  Future<ProcessResult?> runFlutterCommand(
    String path,
    List<String> arguments,
  ) async {
    try {
      return await runExecutableArguments(
        'flutter',
        [...arguments],
        workingDirectory: path,
      );
    } catch (e) {
      print('Error running Flutter command: $e');
    }
    return null;
  }

  // run flutter pub command
  Future<void> runFlutterPubCommand(
    String path,
    List<String> arguments,
  ) async {
    try {
      // output arrguments with out comma

      var res = await runExecutableArguments(
        'flutter',
        ['pub', ...arguments],
        workingDirectory: path,
      );
      print(res.outLines);
      print(res.errText);
    } catch (e) {
      print('Error running Flutter pub command: $e');
    }
  }

  // dart command
  Future<void> runDartCommand(
    String path,
    List<String> arguments,
  ) async {
    try {
      var res = await runExecutableArguments(
        'dart',
        [...arguments],
        workingDirectory: path,
      );

      print(res.outLines);
      print(res.errText);
    } catch (e) {
      print('Error running Dart command: $e');
    }
  }
}
