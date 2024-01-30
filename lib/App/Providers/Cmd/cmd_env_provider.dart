import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:process_run/cmd_run.dart';
import 'package:process_run/process_run.dart';

class CmdEnvProvider {
  // check dart installation
  Future<bool> checkDartInstallation() async {
    try {
      String? res = await which('dart');

      if (res == null) return false;

      return res.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  // check flutter installation
  Future<bool> checkFlutterInstallation() async {
    try {
      String? res = await which('flutter');
      if (res == null) return false;

      return res.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  // check flutter version
  Future<String?> checkFlutterVersion() async {
    try {
      var flutterVersion = await getFlutterBinVersion();

      if (flutterVersion == null) return null;

      return flutterVersion.toString();
    } catch (e) {
      debugPrint('Error checking Flutter version: $e');
      return null;
    }
  }

  // check dart version
  Future<String?> checkDartVersion() async {
    try {
      var dartVersion = await getDartBinVersion();

      if (dartVersion == null) return null;

      return dartVersion.toString();
    } catch (e) {
      debugPrint('Error checking Dart version: $e');
      return null;
    }
  }

  // run flutter doctor
  Future<List<Map<String, dynamic>>?> runFlutterDoctor() async {
    try {
      ProcessResult? res = await runExecutableArguments('flutter', ['doctor']);

      List<Map<String, dynamic>>? resItems = [];

      for (var item in res.stdout.toString().split('\n')) {
        if (item.contains('✓') || item.contains('No issues found!')) {
          resItems.add({'head': true, 'body': item});
        } else if (item.contains('✗')) {
          resItems.add({'head': false, 'body': item});
        }
      }

      return resItems;
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }
}
