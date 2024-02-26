import 'dart:convert';

import 'package:flutterpp/Config/app_print.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _currentVersion = ''.obs;
  String get currentVersion => _currentVersion.value;

  final _lastVersion = ''.obs;
  String get lastVersion => _lastVersion.value;

  final _body = ''.obs;
  String get body => _body.value;

  final _url = ''.obs;
  String get url => _url.value;

  @override
  Future<void> onInit() async {
    await _fetchCurrentVersion();
    await _fetchApi();
    _updateLoading(false);

    AppPrint.print({
      "❌ currentVersion": currentVersion,
      "lastVersion": lastVersion,
    });
    super.onInit();
  }

  // fetch api
  _fetchApi() async {
    final data = await http.get(
      Uri.parse(
        "https://api.github.com/repos/moesaid/FlutterPP_Public/releases/latest",
      ),
    );

    if (data.statusCode == 200) {
      _lastVersion.value = jsonDecode(data.body)["tag_name"];
      _body.value = jsonDecode(data.body)["body"];
      _url.value = jsonDecode(data.body)["html_url"];
    }
  }

  // update loading
  _updateLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  // get latest version
  Future<String> getLatestVersion() async => _lastVersion.value;

  // fetch current version
  _fetchCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;

    if (version.isEmpty) return;

    _currentVersion.value = version;
  }

  // download binary
  Future<String> getBinaryUrl(String? val) async {
    if (val == null) return "";

    // Get the platform extension
    String platformExt, operatingSystem;
    if (GetPlatform.isMacOS) {
      platformExt = "dmg";
      operatingSystem = "macos";
    } else if (GetPlatform.isWindows) {
      platformExt = "exe";
      operatingSystem = "windows";
    } else {
      throw UnsupportedError("Unsupported platform");
    }

    // https://github.com/moesaid/FlutterPP_Public/releases/download/0.0.4/FlutterPP-macos-0.0.4.dmg
    return "https://github.com/moesaid/FlutterPP_Public/releases/download/$val/FlutterPP-$operatingSystem-$val.$platformExt";
  }

  // open url
  Future<void> openUrl(String href) async {
    AppPrint.print({"❌ href": href});

    Uri url = Uri.parse(href);
    if (await canLaunchUrl(url)) {
      launchUrl(url);
    }
  }
}
