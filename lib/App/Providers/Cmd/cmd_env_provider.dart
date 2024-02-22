import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterpp/App/Providers/Cmd/cmd_flutter_provider.dart';
import 'package:flutterpp/App/Views/Global/build_snackbar.dart';

class CmdEnvProvider {
  final CmdFlutterProvider cmd = CmdFlutterProvider();

  // check dart installation
  Future<bool> checkDartInstallation() async {
    try {
      // which dart
      ProcessResult? res = await cmd.runDartCommand(null, ['--version']);

      // Dart SDK version: 3.2.6 (stable) (Wed Jan 24 13:41:58 2024 +0000) on "macos_x64"
      // if res is not null, and return contains 'version' then dart is installed
      return res?.stdout.toString().contains('version') == true;
    } catch (e) {
      BuildSnackBar(
        title: 'Error checking Flutter version',
        message: e.toString(),
      ).error();
      return false;
    }
  }

  // check flutter installation
  Future<bool> checkFlutterInstallation() async {
    try {
      // which flutter
      ProcessResult? res = await cmd.runFlutterCommand(null, ['--version']);

      // flutter 3.16.9 • channel stable •
      // if res is not null, and return contains 'Flutter' then flutter is installed
      return res?.stdout.toString().contains('flutter') == true;
    } catch (e) {
      BuildSnackBar(
        title: 'Error checking Flutter version',
        message: e.toString(),
      ).error();
      return false;
    }
  }

  // check flutter version
  Future<String?> checkFlutterVersion() async {
    try {
      ProcessResult? res = await cmd.runFlutterCommand(
        null,
        ['--version'],
      );

      if (res == null) return null;

      // Flutter 3.16.9 • channel stable • https://github.com/flutter/flutter.git
      // get numbers after 'Flutter'
      String? version = res.stdout.toString().split('Flutter')[1].trim();

      // remove after the number
      version = version.split(' ')[0];

      return version;
    } catch (e) {
      debugPrint('Error checking Flutter version: $e');
      BuildSnackBar(
        title: 'Error checking Flutter version',
        message: e.toString(),
      ).error();
      return null;
    }
  }

  // check dart version
  Future<String?> checkDartVersion() async {
    try {
      // String? dart = await which('dart');
      // ProcessCmd cmd = ProcessCmd(
      //   dart,
      //   ['--version'],
      //   runInShell: true,
      // );
      ProcessResult? res = await cmd.runDartCommand(
        null,
        ['--version'],
      );

      if (res == null) return null;

      // Dart SDK version: 3.2.6 (stable) (Wed Jan 24 13:41:58 2024 +0000) on "macos_x64"
      // get numbers after 'version:'
      String? version = res.stdout.toString().split('version:')[1].trim();

      // remove after the number
      version = version.split(' ')[0];

      return version;
    } catch (e) {
      BuildSnackBar(
        title: 'Error checking Flutter version',
        message: e.toString(),
      ).error();
      return null;
    }
  }

  // run flutter doctor
  Future<List<Map<String, dynamic>>?> runFlutterDoctor() async {
    try {
      // String? path = await which('flutter');
      // ProcessCmd cmd = ProcessCmd(
      //   '$path flutter',
      //   ['doctor'],
      //   runInShell: true,
      // );
      ProcessResult? res = await cmd.runFlutterCommand(
        null,
        ['doctor'],
      );

      if (res == null) return null;

      List<Map<String, dynamic>>? resItems = [];
      for (var item in res.stdout.toString().split('\n')) {
        if (item.contains('✓') || item.contains('No issues found!')) {
          resItems.add({'head': true, 'body': item});
        } else if (item.contains('✗')) {
          resItems.add({'head': false, 'body': item});
        }
      }

      // remove the item when thers 'pod' in the string
      resItems.removeWhere((element) => element['body'].contains('pod'));

      return resItems;
    } catch (e) {
      debugPrint('Error: $e');
      BuildSnackBar(
        title: 'Error checking Flutter version',
        message: e.toString(),
      ).error();
      return null;
    }
  }
}
