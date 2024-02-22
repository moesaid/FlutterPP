import 'dart:io';
import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:flutterpp/App/Services/Global/call_pipeline.dart';
import 'package:flutterpp/Config/app_print.dart';

class FileManegerProvider {
  CallPipeline callPipeline = CallPipeline();

  // Get a directory path
  Future<String?> userPickFileLocation() async {
    String? path = await callPipeline.futurePipeline(
      future: () async {
        final List<String?> locations = await getDirectoryPaths();
        if (locations.isEmpty) {
          // Operation was canceled by the user.
          AppPrint.print('❌canceled by user');
          return null;
        }

        return locations.first;
      },
      name: 'get directory path',
    );

    return path;
  }

  // get save location
  Future<FileSaveLocation?> getSaveFileLocation() async {
    FileSaveLocation? result = await callPipeline.futurePipeline(
      future: () async {
        final FileSaveLocation? result = await getSaveLocation();
        if (result == null) {
          // Operation was canceled by the user.
          AppPrint.print('❌canceled by user');
          return null;
        }
        return result;
      },
      name: 'get save location',
    );

    return result;
  }

  // pick file
  Future<XFile?> pickFile({String? label, List<String>? extensions}) async {
    XFile? file = await callPipeline.futurePipeline(
      future: () async {
        XTypeGroup typeGroup = XTypeGroup(
          label: label ?? 'images',
          extensions: extensions ?? <String>['jpg', 'png'],
        );
        return await openFile(
          acceptedTypeGroups: <XTypeGroup>[typeGroup],
        );
      },
      name: 'pick file',
    );

    return file;
  }

  // save file without location
  Future<void> saveFileWithoutLocation({
    required String fileName,
    required String fileExtension,
    String? data,
    Uint8List? bytes,
  }) async {
    await callPipeline.futurePipeline(
      future: () async {
        String fileNameWithExtension;
        if (fileName.contains('.')) {
          fileNameWithExtension = fileName;
        } else {
          fileNameWithExtension = '$fileName.$fileExtension';
        }

        final FileSaveLocation? result = await getSaveLocation(
          suggestedName: fileNameWithExtension,
        );
        if (result == null) {
          // Operation was canceled by the user.
          AppPrint.print('❌canceled by user');
          return;
        }

        // Write to the file
        final Uint8List fileData;
        if (bytes != null) {
          fileData = bytes;
        } else {
          fileData = Uint8List.fromList(data!.codeUnits);
        }

        final XFile textFile = XFile.fromData(
          fileData,
          mimeType: fileExtension,
          name: fileName,
        );
        await textFile.saveTo(result.path);
      },
      name: 'save file without location',
    );
  }

  // save file
  Future<void> saveFile({
    required String fileName,
    required String fileExtension,
    required String location,
    String? data,
    Uint8List? bytes,
    String? mimeType,
  }) async {
    await callPipeline.futurePipeline(
      future: () async {
        // check if folder exist
        if (!await Directory(location).exists()) {
          AppPrint.print('❌folder not exist');
          return;
        }

        // Write to the file
        final Uint8List fileData;
        if (bytes != null) {
          fileData = bytes;
        } else {
          fileData = Uint8List.fromList(data!.codeUnits);
        }

        final XFile textFile = XFile.fromData(
          fileData,
          mimeType: mimeType,
          name: fileName,
          lastModified: DateTime.now(),
        );

        await textFile.saveTo('$location/$fileName.$fileExtension');
      },
      name: 'save file',
    );
  }

  // create folder
  Future<void> createFolder({
    required String folderName,
    required String location,
  }) async {
    return await callPipeline.futurePipeline(
      future: () async {
        // Create a folder on the desktop
        return Directory('$location/$folderName').createSync();
      },
      name: 'create folder',
    );
  }

  // delete file
  Future<void> deleteFile({
    required String fileName,
    required String fileExtension,
    required String location,
  }) async {
    await callPipeline.futurePipeline(
      future: () async {
        // check if folder exist
        if (!await Directory(location).exists()) {
          AppPrint.print('❌folder not exist');
          return;
        }

        // check if file exist
        if (!await File('$location/$fileName.$fileExtension').exists()) {
          AppPrint.print('❌file not exist');
          return;
        }

        // delete file
        await File('$location/$fileName.$fileExtension').delete();
      },
      name: 'delete file',
    );
  }

  // delete folder
  Future<void> deleteFolder({
    required String folderName,
    required String location,
  }) async {
    await callPipeline.futurePipeline(
      future: () async {
        // check if folder exist
        if (!await Directory('$location/$folderName').exists()) {
          AppPrint.print('❌folder not exist');
          return;
        }

        // delete folder
        await Directory('$location/$folderName').delete(recursive: true);
      },
      name: 'delete folder',
    );
  }

  // rename folder
  Future<void> renameFolder({
    required String folderName,
    required String location,
    required String newName,
  }) async {
    await callPipeline.futurePipeline(
      future: () async {
        // check if folder exist
        if (!await Directory('$location/$folderName').exists()) {
          AppPrint.print('❌folder not exist');
          return;
        }

        // rename folder
        await Directory('$location/$folderName').rename('$location/$newName');
      },
      name: 'rename folder',
    );
  }

  // rename file
  Future<void> renameFile({
    required String fileName,
    required String fileExtension,
    required String location,
    required String newName,
  }) async {
    await callPipeline.futurePipeline(
      future: () async {
        // check if folder exist
        if (!await Directory(location).exists()) {
          AppPrint.print('❌folder not exist');
          return;
        }

        // check if file exist
        if (!await File('$location/$fileName.$fileExtension').exists()) {
          AppPrint.print('❌file not exist');
          return;
        }

        // rename file
        await File('$location/$fileName.$fileExtension')
            .rename('$location/$newName.$fileExtension');
      },
      name: 'rename file',
    );
  }

  // open folder
  Future<void> openFolder({required String location}) async {
    await callPipeline.futurePipeline(
      future: () async {
        // check if folder exist
        if (!await Directory(location).exists()) {
          AppPrint.print('❌folder not exist');
          return;
        }

        // open folder
        await Process.run('open', [location]);
      },
      name: 'open folder',
    );
  }
}
