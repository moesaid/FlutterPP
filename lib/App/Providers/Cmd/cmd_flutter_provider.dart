import 'dart:io';

import 'package:flutterpp/Storage/local_flutter_path.dart';
import 'package:process_run/cmd_run.dart';

class CmdFlutterProvider {
  // get flutter local path
  Future<String?> getFlutterLocalPath() async {
    try {
      return LocalFlutterPath().read();
    } catch (e) {
      print('Error getting Flutter local path: $e');
      return null;
    }
  }

  // run flutter command
  Future<ProcessResult?> runFlutterCommand(
    String? path,
    List<String> arguments,
  ) async {
    try {
      String? flutter = await getFlutterLocalPath();
      if (flutter == null) return null;

      ProcessCmd cmd = ProcessCmd(
        '$flutter/flutter',
        [...arguments],
        workingDirectory: path,
        runInShell: true,
      );
      return await runCmd(cmd);
    } catch (e) {
      print('Error running Flutter command: $e');
    }
    return null;
  }

  // run flutter pub command
  Future<ProcessResult?> runFlutterPubCommand(
    String? path,
    List<String> arguments,
  ) async {
    try {
      String? flutter = await getFlutterLocalPath();
      if (flutter == null) return null;

      ProcessCmd cmd = ProcessCmd(
        '$flutter/flutter',
        ['pub', ...arguments],
        workingDirectory: path,
        runInShell: true,
      );
      return await runCmd(cmd);
    } catch (e) {
      print('Error running Flutter pub command: $e');
      return null;
    }
  }

  // dart command
  Future<ProcessResult?> runDartCommand(
    String? path,
    List<String> arguments,
  ) async {
    try {
      String? flutter = await getFlutterLocalPath();
      if (flutter == null) return null;

      ProcessCmd cmd = ProcessCmd(
        '$flutter/dart',
        [...arguments],
        workingDirectory: path,
        runInShell: true,
      );
      return await runCmd(cmd);
    } catch (e) {
      print('Error running Dart command: $e');
      return null;
    }
  }
}
