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
      await runExecutableArguments('mkdir', ['-p', path]);
    } catch (e) {
      print('Error creating directory: $e');
    }
  }

  // create file
  Future<void> createFile(String path) async {
    try {
      await runExecutableArguments('touch', [path]);
    } catch (e) {
      print('Error creating file: $e');
    }
  }

  // create file with content
  Future<void> createFileWithContent(String path, String content) async {
    try {
      await File(path).writeAsString(content);
    } catch (e) {
      print('Error creating file: $e');
    }
  }

  // append to file
  Future<void> appendToFile({
    required String path,
    required String content,
    FileAppendPosition position = FileAppendPosition.bottom,
  }) async {
    // append to file
    try {
      // write to the top of the file
      var file = File(path);
      var lines = file.readAsLinesSync();

      // if top append to top of the file and add new line of space in between and same for bottom
      if (position == FileAppendPosition.top) {
        lines.insert(0, content);
      } else {
        // add new line of space in between
        lines.add('');
        lines.add(content);
      }

      await file.writeAsString(lines.join('\n').trim());
    } catch (e) {
      print('Error appending to file: $e');
    }
  }

  // delete file if exist
  Future<void> deleteFile(String path) async {
    try {
      // check if file exist
      if (!await File(path).exists()) {
        print('❌file not exist');
        return;
      }

      // delete file
      await File(path).delete();
    } catch (e) {
      print('Error deleting file: $e');
    }
  }
}

enum FileAppendPosition {
  top,
  bottom,
}
