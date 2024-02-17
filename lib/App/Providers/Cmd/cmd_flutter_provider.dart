import 'dart:io';

import 'package:flutterpp/App/Views/Global/build_snackbar.dart';
import 'package:flutterpp/Storage/local_flutter_path.dart';
import 'package:get/get.dart';
import 'package:process_run/cmd_run.dart';

class CmdFlutterProvider {
  // get flutter local path
  Future<String?> getFlutterLocalPath() async {
    try {
      String? path = LocalFlutterPath().read();
      if (path != null) return path;

      // get dart path from env variables using shell
      String? res;

      if (GetPlatform.isWindows) {
        String command = 'for %A in ("%PATH:;=" "%") do @echo %~A';
        ProcessResult result = await Process.run('cmd', ['/c', command]);

        List<String> paths = result.stdout.toString().split(';');

        // find dart path
        for (var path in paths) {
          if (path.contains('flutter')) {
            res = path;
            break;
          }
        }
      } else if (GetPlatform.isMacOS) {
        String command = 'echo \$PATH | tr \':\' \'\\n\'';
        ProcessResult result = await Process.run('/bin/bash', ['-c', command]);

        List<String> paths = result.stdout.toString().split('\n');

        // find flutter path
        for (var path in paths) {
          if (path.contains('flutter')) {
            res = path;
            break;
          }
        }
      }

      if (res == null || res.isEmpty) {
        BuildSnackBar(
          title: 'Error',
          message: path.toString(),
        ).error();
        return null;
      }

      // write to local file
      LocalFlutterPath().write(res);

      return res;
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
