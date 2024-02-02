import 'package:flutterpp/App/Providers/Cmd/cmd_flutter_provider.dart';
import 'package:flutterpp/App/Services/Cmd/cmd_read_create_dir_services.dart';

class CmdInitGetxMvcServices {
  final CmdReadCreateDirServices _cmdRCD = CmdReadCreateDirServices();
  final CmdFlutterProvider _cmdF = CmdFlutterProvider();

  // init
  Future<void> init(String path) async {
    // await createProjectStructure(path);
    // await _cmdRCD.createDefultFlutterppYaml(path);

    // create configration files
    await _cmdRCD.configDefaultAnalysisOptions(path);
    await _cmdRCD.createDefultFlutterppYaml(path);

    // install dependencies
    await _cmdF.runFlutterPubCommand(path, ['add', 'get']);
    await _cmdF.runFlutterPubCommand(path, ['add', 'get_storage']);
    await _cmdF.runFlutterPubCommand(path, ['add', 'freezed_annotation']);
    await _cmdF.runFlutterPubCommand(path, ['add', 'json_annotation']);

    // dev dependencies
    await _cmdF.runFlutterPubCommand(path, ['add', 'dev:build_runner']);
    await _cmdF.runFlutterPubCommand(path, ['add', 'dev:freezed']);
    await _cmdF.runFlutterPubCommand(path, ['add', 'dev:json_serializable']);

    // create default files
    // await createProjectStructure(path);

    // dart fix
    // await _cmdF.runDartCommand(path, ['fix', '--apply']);
    // await _cmdF.runDartCommand(path, ['format', '.']);
  }

  // create project structure
  Future<void> createProjectStructure(String path) async {
    await _cmdRCD.createDirectory('$path/lib/App/Controllers/Counter');
    await _cmdRCD.createDirectory('$path/lib/App/Enums');
    await _cmdRCD.createDirectory('$path/lib/App/Providers');
    await _cmdRCD.createDirectory('$path/lib/App/Services');
    await _cmdRCD.createDirectory('$path/lib/App/Views/Global/Atoms');
    await _cmdRCD.createDirectory('$path/lib/App/Views/Global/Molecules');
    await _cmdRCD.createDirectory('$path/lib/App/Views/Global/Organisms');
    await _cmdRCD.createDirectory('$path/lib/App/Views/Global/Layouts');
    await _cmdRCD.createDirectory('$path/lib/App/Views/Pages/Counter/Widgets');
    await _cmdRCD.createDirectory('$path/lib/Core/Bindings');
    await _cmdRCD.createDirectory('$path/lib/Core/Config');
    await _cmdRCD.createDirectory('$path/lib/Core/Theme');
    await _cmdRCD.createDirectory('$path/lib/Helpers');
    await _cmdRCD.createDirectory('$path/lib/Middlewares');
    await _cmdRCD.createDirectory('$path/lib/Routes');
    await _cmdRCD.createDirectory('$path/lib/Storage');
  }
}
