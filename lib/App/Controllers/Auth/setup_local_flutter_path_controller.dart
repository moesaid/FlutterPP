import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:flutterpp/App/Views/Global/build_snackbar.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:flutterpp/Storage/local_flutter_path.dart';
import 'package:get/get.dart';
import 'package:process_run/cmd_run.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class SetupLocalFlutterPathController extends GetxController {
  late HighlighterTheme theme;
  final LocalFlutterPath localFlutterPath = LocalFlutterPath();

  final _isLoading = true.obs;
  get isLoading => _isLoading.value;

  // codes
  final List<Map<String, String>> codes = [
    {
      'mac': 'echo \$PATH | tr \':\' \'\\n\'',
      'windows': 'for %A in ("%PATH:;=" "%") do @echo %~A',
    },
  ];

  List<String> pathsList = [
    '/opt/homebrew/opt/libpq/bin',
    '/usr/local/opt/node@16/bin',
    '/Users/username/.local/share/solana/install/active_release/bin',
    '/Users/username/.composer/vendor/bin',
    '/Users/username/Development/flutter_workshop/flutter/bin',
    '/usr/local/bin',
    '/System/Cryptexes/App/usr/bin',
    '/usr/bin',
    '/Users/username/.cargo/bin',
    '/usr/local/bin',
    '/Users/username/.pub-cache/bin',
    '/Users/username/Library/Android/sdk/platform-tools/'
  ];

  @override
  Future<void> onInit() async {
    await _fetchApi();
    updateLoading(false);
    super.onInit();
  }

  // fetch api
  _fetchApi() async {
    await getTheme();
  }

  // update loading
  updateLoading(bool val) {
    _isLoading.value = val;
    update();
  }

  // get theme
  getTheme() async {
    HighlighterTheme local = await HighlighterTheme.loadDarkTheme();
    theme = local;
  }

  Future<void> onCopy(String val) async {
    await FlutterClipboard.copy(val);
  }

  // add path
  addPath(String path) async {
    // remove last /
    if (path.endsWith('/')) {
      path = path.substring(0, path.length - 1);
    }

    // check if is excutable
    ProcessCmd cmd =
        ProcessCmd('$path/flutter', ['--version'], runInShell: true);
    ProcessResult result = await runCmd(cmd);

    // if error
    if (result.exitCode != 0) {
      BuildSnackBar(
        title: 'Error',
        message: 'Invalid Flutter path',
      ).error();

      return;
    }

    // write to local file
    await localFlutterPath.write(path);

    // await localFlutterPath.write(path);
    Get.offAllNamed(AppRoutes.SPLASH);
  }
}
