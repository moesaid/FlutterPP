import 'package:flutterpp/App/Enums/state_manegment_enum.dart';
import 'package:flutterpp/App/Models/build_option_model.dart';
import 'package:flutterpp/App/Providers/Cmd/cmd_flutter_provider.dart';
import 'package:flutterpp/App/Providers/Device/file_maneger_provider.dart';
import 'package:flutterpp/App/Providers/FilesGen/Bloc/file_gen_bloc_counter_case.dart';
import 'package:flutterpp/App/Providers/FilesGen/Bloc/file_gen_bloc_provider.dart';
import 'package:flutterpp/App/Providers/FilesGen/build_runner_provider.dart';
import 'package:flutterpp/App/Providers/FilesGen/go_router_gen_provider.dart';
import 'package:flutterpp/App/Providers/FilesGen/vs_code_provider.dart';
import 'package:flutterpp/App/Providers/Yaml/yaml_provider.dart';
import 'package:flutterpp/App/Services/Cmd/cmd_flutter_create.dart';
import 'package:flutterpp/App/Services/Cmd/cmd_read_create_dir_services.dart';
import 'package:flutterpp/Helpers/text_helper.dart';

class CmdInitBlocServices {
  final VsCodeProvider _vsCode = VsCodeProvider();
  final CmdReadCreateDirServices _cmdRCD = CmdReadCreateDirServices();
  final CmdFlutterProvider _cmdF = CmdFlutterProvider();
  final YamlProvider _ymal = YamlProvider();
  final FileGenBlocProvider _fileGen = FileGenBlocProvider();
  final FileGenBlocCounterCase _fileGenCase = FileGenBlocCounterCase();
  final GoRouterGenProvider _router = GoRouterGenProvider();
  final BuildRunnerProvider _build = BuildRunnerProvider();
  final FileManegerProvider _fileManeger = FileManegerProvider();

  // create project
  Future<String?> createProject(String name) async {
    String? path = await _fileManeger.userPickFileLocation();
    if (path == null) return null;

    await CmdFlutterCreate(path, name.toFlutterFileName()).run();
    String projectPath = '$path/${name.toFlutterFileName()}';

    await init(projectPath);

    return projectPath;
  }

  // init
  Future<void> init(String path) async {
    // get name space
    String nameSpace = await _ymal.getNameSpace('$path/pubspec.yaml');

    // create vs code settings
    await _vsCode.vsCodeSettingsGen(path);
    await _build.createBuildYaml(path);

    // create configration files
    await _cmdRCD.configDefaultAnalysisOptions(path);
    await _cmdRCD.createDefultFlutterppYaml(
      path,
      state: StateManegmentEnum.bloc,
    );

    // install dependencies
    await _cmdF.runFlutterPubCommand(path, ['add', 'flutter_bloc']);
    await _cmdF.runFlutterPubCommand(path, ['add', 'go_router']);
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
    await _cmdRCD.createDirectory('$path/lib/App/Blocs');
    await _cmdRCD.createDirectory('$path/lib/App/Cubits');
    await _cmdRCD.createDirectory('$path/lib/App/Models');
    await _cmdRCD.createDirectory('$path/lib/App/Enums');
    await _cmdRCD.createDirectory('$path/lib/App/Providers');
    await _cmdRCD.createDirectory('$path/lib/App/Services');
    await _cmdRCD.createDirectory('$path/lib/App/Views/Global/Atoms');
    await _cmdRCD.createDirectory('$path/lib/App/Views/Global/Molecules');
    await _cmdRCD.createDirectory('$path/lib/App/Views/Global/Organisms');
    await _cmdRCD.createDirectory('$path/lib/App/Views/Global/Layouts');
    await _cmdRCD.createDirectory('$path/lib/App/Views/Pages');
    await _cmdRCD.createDirectory('$path/lib/Config/Exernal');
    await _cmdRCD.createDirectory('$path/lib/Config/Theme');
    await _cmdRCD.createDirectory('$path/lib/Helpers');
    await _cmdRCD.createDirectory('$path/lib/Routes');
    await _cmdRCD.createDirectory('$path/lib/Storage');
  }

  // create init case
  createInitCase(String nameSpace, String path) async {
    String blocPath = '$path/lib/App/Blocs';
    String cubitsPath = '$path/lib/App/Cubits';
    String pagePath = '$path/lib/App/Views/Pages';

    // main
    await _fileGen.mainGen(nameSpace, path);

    // remove Test folder
    await _fileGen.removeTestFolder(path);

    // routes
    await _fileGen.appRoutesGen('$path/lib/Routes');
    await _fileGen.appPagesGen(nameSpace, '$path/lib/Routes');

    // initlaizer
    await _fileGen.appInitializerGen('$path/lib/Config/Exernal');

    // themes
    await _fileGen.appThemeGen('$path/lib/Config/Theme');

    // create directories
    await _cmdRCD.createDirectory('$cubitsPath/Counter');
    await _cmdRCD.createDirectory('$cubitsPath/Home');
    await _cmdRCD.createDirectory('$cubitsPath/Auth');
    await _cmdRCD.createDirectory('$blocPath/Theme');
    await _cmdRCD.createDirectory('$pagePath/Counter');
    await _cmdRCD.createDirectory('$pagePath/Home');
    await _cmdRCD.createDirectory('$pagePath/Auth');

    // create controller
    await _fileGenCase.counterCubitGen(
      'counter',
      '$cubitsPath/Counter',
    );
    await _fileGenCase.homeCubitGen('home', '$cubitsPath/Home');
    await _fileGenCase.splashCubitGen(nameSpace, 'splash', '$cubitsPath/Auth');

    // create page
    await _fileGenCase.pageGenCounter(
      nameSpace,
      'counter',
      '$pagePath/Counter',
    );
    await _fileGenCase.pageGenHome(nameSpace, 'home', '$pagePath/Home');
    await _fileGenCase.pageGenSplash(
      nameSpace,
      'splash',
      '$pagePath/Auth',
      custom: 'auth',
    );

    // theme
    await _fileGenCase.themeBlocGen(nameSpace, '$blocPath/Theme');
    await _fileGenCase.themeStorageGen(nameSpace, '$path/lib/Storage');
  }

  // create Case for GetX MVC
  Future<void> createCase(
    String path,
    String caseName, {
    bool? isCrud,
    required BuildOptionModel option,
  }) async {
    String nameSpace = await _ymal.getNameSpace('$path/pubspec.yaml');
    String blocPath = '$path/lib/App/Blocs';
    String cubitPath = '$path/lib/App/Cubits';
    String pagePath = '$path/lib/App/Views/Pages';
    bool isBloc = option.blocs == true;

    // format and fix files
    await _cmdF.runDartCommand(path, ['fix', '--apply']);
    await _cmdF.runDartCommand(path, ['format', '.']);

    // create directories
    if (option.blocs == true) {
      await _cmdRCD.createDirectory('$blocPath/${caseName.toFolderName()}');
      if (isCrud == true) {
        await _cmdRCD
            .createDirectory('$blocPath/${caseName.toFolderName()}/Index');
        await _cmdRCD
            .createDirectory('$blocPath/${caseName.toFolderName()}/Single');
        await _cmdRCD
            .createDirectory('$blocPath/${caseName.toFolderName()}/Create');
        await _cmdRCD
            .createDirectory('$blocPath/${caseName.toFolderName()}/Edit');
      }
    }

    if (option.cubits == true) {
      await _cmdRCD.createDirectory('$cubitPath/${caseName.toFolderName()}');
      if (isCrud == true) {
        await _cmdRCD
            .createDirectory('$cubitPath/${caseName.toFolderName()}/Index');
        await _cmdRCD
            .createDirectory('$cubitPath/${caseName.toFolderName()}/Single');
        await _cmdRCD
            .createDirectory('$cubitPath/${caseName.toFolderName()}/Create');
        await _cmdRCD
            .createDirectory('$cubitPath/${caseName.toFolderName()}/Edit');
      }
    }

    if (option.pages == true) {
      await _cmdRCD.createDirectory('$pagePath/${caseName.toFolderName()}');
    }

    // create blocs
    if (isCrud == true && option.blocs == true) {
      await _fileGen.blocGen(
        nameSpace,
        '${caseName}Index',
        '$blocPath/${caseName.toFolderName()}/Index',
        custom: '$caseName/Index',
      );
      await _fileGen.blocGen(
        nameSpace,
        '${caseName}Single',
        '$blocPath/${caseName.toFolderName()}/Single',
        custom: '$caseName/Single',
      );
      await _fileGen.blocGen(
        nameSpace,
        '${caseName}Create',
        '$blocPath/${caseName.toFolderName()}/Create',
        custom: '$caseName/Create',
      );
      await _fileGen.blocGen(
        nameSpace,
        '${caseName}Edit',
        '$blocPath/${caseName.toFolderName()}/Edit',
        custom: '$caseName/Edit',
      );
    } else if (isCrud == false && option.blocs == true) {
      await _fileGen.blocGen(
        nameSpace,
        caseName,
        '$blocPath/${caseName.toFolderName()}',
      );
    }

    // create cubits
    if (isCrud == true && option.cubits == true) {
      await _fileGen.cubitGen(
        '${caseName}Index',
        '$cubitPath/${caseName.toFolderName()}/Index',
      );
      await _fileGen.cubitGen(
        '${caseName}Single',
        '$cubitPath/${caseName.toFolderName()}/Single',
      );
      await _fileGen.cubitGen(
        '${caseName}Create',
        '$cubitPath/${caseName.toFolderName()}/Create',
      );
      await _fileGen.cubitGen(
        '${caseName}Edit',
        '$cubitPath/${caseName.toFolderName()}/Edit',
      );
    } else if (isCrud == false && option.cubits == true) {
      await _fileGen.cubitGen(
        caseName,
        '$cubitPath/${caseName.toFolderName()}',
      );
    }

    // create page
    if (isCrud == true && option.pages == true) {
      await _fileGen.pageGen(
        nameSpace,
        '${caseName}Index',
        custom: '$caseName/Index',
        '$pagePath/${caseName.toFolderName()}',
        isBloc: isBloc,
        isCubit: option.blocs == null && option.cubits == true,
      );
      await _fileGen.pageGen(
        nameSpace,
        '${caseName}Single',
        '$pagePath/${caseName.toFolderName()}',
        custom: '$caseName/Single',
        isBloc: isBloc,
        isCubit: option.blocs == null && option.cubits == true,
      );
      await _fileGen.pageGen(
        nameSpace,
        '${caseName}Create',
        '$pagePath/${caseName.toFolderName()}',
        custom: '$caseName/Create',
        isBloc: isBloc,
        isCubit: option.blocs == null && option.cubits == true,
      );
      await _fileGen.pageGen(
        nameSpace,
        '${caseName}Edit',
        '$pagePath/${caseName.toFolderName()}',
        custom: '$caseName/Edit',
        isBloc: isBloc,
        isCubit: option.blocs == null && option.cubits == true,
      );
    } else if (isCrud == false && option.pages == true) {
      await _fileGen.pageGen(
        nameSpace,
        caseName,
        '$pagePath/${caseName.toFolderName()}',
        isBloc: isBloc,
        isCubit: option.blocs == null && option.cubits == true,
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
