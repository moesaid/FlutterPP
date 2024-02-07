import 'package:flutterpp/App/Models/build_option_model.dart';
import 'package:flutterpp/App/Providers/Cmd/cmd_flutter_provider.dart';
import 'package:flutterpp/App/Providers/FilesGen/Getx/file_gen_getx_counter_case.dart';
import 'package:flutterpp/App/Providers/FilesGen/Getx/file_gen_getx_provider.dart';
import 'package:flutterpp/App/Providers/FilesGen/Getx/file_gen_gex_binding_provider.dart';
import 'package:flutterpp/App/Providers/FilesGen/Getx/file_gen_gex_router_provider.dart';
import 'package:flutterpp/App/Providers/FilesGen/build_runner_provider.dart';
import 'package:flutterpp/App/Providers/FilesGen/vs_code_provider.dart';
import 'package:flutterpp/App/Providers/Yaml/yaml_provider.dart';
import 'package:flutterpp/App/Services/Cmd/cmd_read_create_dir_services.dart';
import 'package:flutterpp/Helpers/text_helper.dart';

class CmdInitGetxMvcServices {
  final VsCodeProvider _vsCode = VsCodeProvider();
  final CmdReadCreateDirServices _cmdRCD = CmdReadCreateDirServices();
  final CmdFlutterProvider _cmdF = CmdFlutterProvider();
  final YamlProvider _ymal = YamlProvider();
  final FileGenGetxProvider _fileGen = FileGenGetxProvider();
  final FileGenGetxCounterCase _fileGenCase = FileGenGetxCounterCase();
  final FileGenGexBindingProvider _binding = FileGenGexBindingProvider();
  final FileGenGetxRouterProvider _router = FileGenGetxRouterProvider();
  final BuildRunnerProvider _build = BuildRunnerProvider();

  // init
  Future<void> init(String path) async {
    // get name space
    String nameSpace = await _ymal.getNameSpace('$path/pubspec.yaml');

    // create vs code settings
    await _vsCode.vsCodeSettingsGen(path);
    await _build.createBuildYaml(path);

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
    await createProjectStructure(path);

    // generate initial case
    await createInitCase(nameSpace, path);

    // dart fix
    await _cmdF.runDartCommand(path, ['fix', '--apply']);
    await _cmdF.runDartCommand(path, ['format', '.']);
  }

  // create project structure
  Future<void> createProjectStructure(String path) async {
    await _cmdRCD.createDirectory('$path/lib/App/Controllers');
    await _cmdRCD.createDirectory('$path/lib/App/Models');
    await _cmdRCD.createDirectory('$path/lib/App/Enums');
    await _cmdRCD.createDirectory('$path/lib/App/Providers');
    await _cmdRCD.createDirectory('$path/lib/App/Services');
    await _cmdRCD.createDirectory('$path/lib/App/Views/Global/Atoms');
    await _cmdRCD.createDirectory('$path/lib/App/Views/Global/Molecules');
    await _cmdRCD.createDirectory('$path/lib/App/Views/Global/Organisms');
    await _cmdRCD.createDirectory('$path/lib/App/Views/Global/Layouts');
    await _cmdRCD.createDirectory('$path/lib/App/Views/Pages/Counter/Widgets');
    await _cmdRCD.createDirectory('$path/lib/Config/Bindings');
    await _cmdRCD.createDirectory('$path/lib/Config/Exernal');
    await _cmdRCD.createDirectory('$path/lib/Config/Theme');
    await _cmdRCD.createDirectory('$path/lib/Helpers');
    await _cmdRCD.createDirectory('$path/lib/Middlewares');
    await _cmdRCD.createDirectory('$path/lib/Routes');
    await _cmdRCD.createDirectory('$path/lib/Storage');
  }

  // create init case
  createInitCase(String nameSpace, String path) async {
    String controllerPath = '$path/lib/App/Controllers';
    String pagePath = '$path/lib/App/Views/Pages';

    // main
    await _fileGen.mainGen(nameSpace, path);

    // remove Test folder
    await _fileGen.removeTestFolder(path);

    // routes
    await _fileGen.appRoutesGen('$path/lib/Routes');
    await _fileGen.appPagesGen(nameSpace, '$path/lib/Routes');

    // app binding
    await _fileGen.bindingGen(nameSpace, '$path/lib/Config/Bindings');

    // initlaizer
    await _fileGen.appInitializerGen('$path/lib/Config/Exernal');

    // themes
    await _fileGen.appThemeGen('$path/lib/Config/Theme');

    // create directories
    await _cmdRCD.createDirectory('$controllerPath/Counter');
    await _cmdRCD.createDirectory('$controllerPath/Home');
    await _cmdRCD.createDirectory('$controllerPath/Auth');
    await _cmdRCD.createDirectory('$pagePath/Counter');
    await _cmdRCD.createDirectory('$pagePath/Home');
    await _cmdRCD.createDirectory('$pagePath/Auth');

    // create controller
    await _fileGenCase.counterControllerGen(
      'counter',
      '$controllerPath/Counter',
    );
    await _fileGenCase.homeControllerGen('home', '$controllerPath/Home');
    await _fileGenCase.splashControllerGen('splash', '$controllerPath/Auth');

    // create page
    await _fileGenCase.pageGenCounter(
        nameSpace, 'counter', '$pagePath/Counter');
    await _fileGenCase.pageGenHome(nameSpace, 'home', '$pagePath/Home');
    await _fileGenCase.pageGenSplash(
      nameSpace,
      'splash',
      '$pagePath/Auth',
      custom: 'auth',
    );
  }

  // create Case for GetX MVC
  Future<void> createCase(
    String path,
    String caseName, {
    bool? isCrud,
    required BuildOptionModel option,
  }) async {
    String nameSpace = await _ymal.getNameSpace('$path/pubspec.yaml');
    String controllerPath = '$path/lib/App/Controllers';
    String pagePath = '$path/lib/App/Views/Pages';
    String bindingPath = '$path/lib/Config/Bindings/app_binding.dart';

    // format and fix files
    await _cmdF.runDartCommand(path, ['fix', '--apply']);
    await _cmdF.runDartCommand(path, ['format', '.']);

    // create directories
    if (option.controllers == true) {
      await _cmdRCD.createDirectory(
        '$controllerPath/${caseName.toFolderName()}',
      );
    }

    if (option.pages == true) {
      await _cmdRCD.createDirectory('$pagePath/${caseName.toFolderName()}');
    }

    // create controller
    if (isCrud == true && option.controllers == true) {
      await _fileGen.controllerGen(
        '${caseName}Index',
        '$controllerPath/${caseName.toFolderName()}',
      );
      await _fileGen.controllerGen(
        '${caseName}Single',
        '$controllerPath/${caseName.toFolderName()}',
      );
      await _fileGen.controllerGen(
        '${caseName}Create',
        '$controllerPath/${caseName.toFolderName()}',
      );
      await _fileGen.controllerGen(
        '${caseName}Edit',
        '$controllerPath/${caseName.toFolderName()}',
      );
    } else if (isCrud == false && option.controllers == true) {
      await _fileGen.controllerGen(
        caseName,
        '$controllerPath/${caseName.toFolderName()}',
      );
    }

    // create page
    if (isCrud == true && option.pages == true) {
      await _fileGen.pageGen(
        nameSpace,
        '${caseName}Index',
        '$pagePath/${caseName.toFolderName()}',
        custom: caseName,
      );
      await _fileGen.pageGen(
        nameSpace,
        '${caseName}Single',
        '$pagePath/${caseName.toFolderName()}',
        custom: caseName,
      );
      await _fileGen.pageGen(
        nameSpace,
        '${caseName}Create',
        '$pagePath/${caseName.toFolderName()}',
        custom: caseName,
      );
      await _fileGen.pageGen(
        nameSpace,
        '${caseName}Edit',
        '$pagePath/${caseName.toFolderName()}',
        custom: caseName,
      );
    } else if (isCrud == false && option.pages == true) {
      await _fileGen.pageGen(
        nameSpace,
        caseName,
        '$pagePath/${caseName.toFolderName()}',
      );
    }

    // add binding
    if (option.bindings == true) {
      await _binding.updateBindingFile(
        nameSpace,
        bindingPath,
        caseName,
        isCrud ?? false,
      );
    }

    // router
    if (option.routes == true) {
      await _router.updateAppRoutes(
        nameSpace,
        '$path/lib/Routes/app_routes.dart',
        caseName,
        isCrud: isCrud,
      );
      await _router.updateAppPages(
        nameSpace,
        '$path/lib/Routes/app_pages.dart',
        caseName,
        isCrud: isCrud,
      );
    }

    // format and fix files
    await _cmdF.runDartCommand(path, ['fix', '--apply']);
    await _cmdF.runDartCommand(path, ['format', '.']);
  }
}
