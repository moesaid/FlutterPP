import 'dart:async';
import 'dart:io';

import 'package:flutterpp/Config/app_print.dart';
import 'package:get/get.dart';
import 'package:process_run/cmd_run.dart';
import 'package:process_run/process_run.dart';

class CmdReadCreateDirProvider {
  // list directory
  Future<List<String>?> listDirectory(
    String path, {
    String? option,
  }) async {
    try {
      String command = GetPlatform.isWindows ? 'dir /d /a-d' : 'ls';

      // var result = await runExecutableArguments(command, [option ?? '', path]);

      ProcessCmd cmd = ProcessCmd(
        command,
        [option ?? '', path],
        runInShell: true,
      );

      ProcessResult result = await runCmd(cmd);

      AppPrint.print('errors: ${result.errLines}');
      AppPrint.print('listDirectory: ${result.outLines}');

      List<String> res = [];
      for (var item in result.outLines) {
        if (item == '$path:') continue;
        res.add(item);
      }

      return res;
    } catch (e) {
      AppPrint.print('Error listing directory: $e');
      return null;
    }
  }

  Future<void> createDirectory(String path) async {
    try {
      //ProcessResult res =  = await runExecutableArguments('mkdir', ['-p', path]);

      ProcessCmd cmd = ProcessCmd(
        'mkdir',
        [
          GetPlatform.isWindows ? '' : '-p',
          path,
        ],
        runInShell: true,
      );
      ProcessResult res = await runCmd(cmd);

      AppPrint.print('mkdir: ${res.stdout}');
    } catch (e) {
      AppPrint.print('Error creating directory: $e');
    }
  }

  // create file
  Future<void> createFile(String path) async {
    String command = GetPlatform.isWindows ? 'type nul' : 'touch';

    try {
      // await runExecutableArguments('touch', [path]);

      ProcessCmd cmd = ProcessCmd(
        command,
        [path],
        runInShell: true,
      );

      ProcessResult res = await runCmd(cmd);

      AppPrint.print('touch: ${res.stdout}');
    } catch (e) {
      AppPrint.print('Error creating file: $e');
    }
  }

  // create file with content
  Future<void> createFileWithContent(String path, String content) async {
    try {
      await File(path).writeAsString(content);
    } catch (e) {
      AppPrint.print('Error creating file: $e');
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
      AppPrint.print('Error appending to file: $e');
    }
  }

  // delete file if exist
  Future<void> deleteFile(String path) async {
    try {
      // check if file exist
      if (!await File(path).exists()) {
        AppPrint.print('❌file not exist');
        return;
      }

      // delete file
      await File(path).delete();
    } catch (e) {
      AppPrint.print('Error deleting file: $e');
    }
  }
}

enum FileAppendPosition {
  top,
  bottom,
}
