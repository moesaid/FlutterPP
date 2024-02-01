import 'package:flutterpp/App/Providers/Cmd/cmd_read_create_dir_provider.dart';

class CmdReadCreateDirServices {
  final CmdReadCreateDirProvider _dirProvider = CmdReadCreateDirProvider();

  // read dir
  Future<bool> isFlutterPPProject(String path) async {
    List<String>? res = await _dirProvider.listDirectory(path);

    // check if theres a .flutterpp file
    if (res != null) {
      return res.contains('.flutterpp');
    }

    return false;
  }
}
