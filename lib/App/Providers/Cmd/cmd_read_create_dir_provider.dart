import 'dart:async';
import 'dart:io';

import 'package:process_run/process_run.dart';

class CmdReadCreateDirProvider {
  // list directory
  Future<List<String>?> listDirectory(
    String path, {
    String? option,
  }) async {
    try {
      var result = await runExecutableArguments('ls', [option ?? '', path]);

      List<String> res = [];
      for (var item in result.outLines) {
        res.add(item);
      }

      return res;
    } catch (e) {
      print('Error listing directory: $e');
      return null;
    }
  }

  Future<void> createDirectory(String path) async {
    try {
      await runExecutableArguments('mkdir', [path]);
      print('Directory created at $path');
    } catch (e) {
      print('Error creating directory: $e');
    }
  }

  Future<void> createFile(String path, String content) async {
    try {
      await File(path).writeAsString(content);
      print('File created at $path');
    } catch (e) {
      print('Error creating file: $e');
    }
  }
}
