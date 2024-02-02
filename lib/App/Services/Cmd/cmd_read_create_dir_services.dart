import 'package:flutterpp/App/Providers/Cmd/cmd_read_create_dir_provider.dart';
import 'package:json2yaml/json2yaml.dart';

class CmdReadCreateDirServices {
  final CmdReadCreateDirProvider _dirProvider = CmdReadCreateDirProvider();

  // is FlutterPP Project dir
  Future<bool> isFlutterPPProject(String path) async {
    List<String>? res = await _dirProvider.listDirectory(path);

    // check if theres a .flutterpp file
    if (res != null) {
      return res.contains('.flutterpp');
    }

    return false;
  }

  // read all files in a directory
  Future<List<String>?> readDirectory(
    String path, {
    String? option,
  }) async {
    return await _dirProvider.listDirectory(path, option: option);
  }

  // create project structure
  Future<void> createDirectory(String path) async {
    await _dirProvider.createDirectory(path);
  }

  // create default flutterpp.yaml
  Future<void> createDefultFlutterppYaml(String path) async {
    var developerData = {
      'owner': 'FlutterPP',
      'description': 'FlutterPP Project Configration file',
      'path': path,
      'version': '0.0.1',
      'base': {
        'language': 'dart',
        'framework': 'flutter',
      },
      'principles': {
        'ui_methodology': 'atomic_design',
        'architectural_pattern': 'MVC',
        'state_management': 'GetX',
        'routing': 'GetRouter',
        'dependency_injection': 'GetBindings',
      },
      'default_dependency': [
        'get',
        'get_storage',
        'freezed_annotation',
        'json_annotation',
      ],
      'default_dev_dependency': [
        'build_runner',
        'freezed',
        'json_serializable',
      ],
    };

    // create file
    await _dirProvider.createFileWithContent(
      '$path/flutterpp.yaml',
      json2yaml(developerData, yamlStyle: YamlStyle.pubspecYaml),
    );

    // append to file
    await _dirProvider.appendToFile(
      path: '$path/flutterpp.yaml',
      content: '# 🚫 Caution: Hands-off zone! 🙌 - no touchy-touchy allowed'
          '\n# To modify the project configuration, please utilize the FlutterPP Interface.'
          '\n# Manual configuration is on the task list - just not in this lifetime. 🛠️📅',
      position: FileAppendPosition.top,
    );
  }

  // config default analysis_options.yaml
  Future<void> configDefaultAnalysisOptions(String path) async {
    var options = {
      'include': 'package:flutter_lints/flutter.yaml',
      'analyzer': {
        'errors': {
          'invalid_annotation_target': 'ignore',
        },
        'language': {
          'strict-casts': true,
          'strict-raw-types': true,
        },
        'exclude': [
          '**/*.freezed.dart',
          '**/*.g.dart',
        ],
      },
      'linter': {
        'rules': [
          // constructor
          'sort_unnamed_constructors_first',
          'sort_constructors_first',
          'prefer_const_constructors',
          'use_key_in_widget_constructors',
          'avoid_unused_constructor_parameters',

          // imports
          'always_use_package_imports',
          'directives_ordering',
          'combinators_ordering',
          'depend_on_referenced_packages',
          'avoid_web_libraries_in_flutter',

          // Types
          'unrelated_type_equality_checks',
          'avoid_types_on_closure_parameters',
          'prefer_void_to_null',

          // Style
          'prefer_single_quotes',
          'require_trailing_commas',
          'noop_primitive_operations',
          'use_super_parameters',
          'avoid_redundant_argument_values',
          'avoid_renaming_method_parameters',
          'avoid_private_typedef_functions',
          'avoid_void_async',
          'cancel_subscriptions',
          'cascade_invocations',
          'no_runtimeType_toString',
          'prefer_const_declarations',
          'prefer_final_locals',
          'sort_child_properties_last',
          'unnecessary_breaks',
        ],
      }
    };

    // remove the file if exists
    await _dirProvider.deleteFile('$path/analysis_options.yaml');

    // create file
    await _dirProvider.createFileWithContent(
      '$path/analysis_options.yaml',
      json2yaml(options, yamlStyle: YamlStyle.pubspecYaml),
    );

    // append to file
    await _dirProvider.appendToFile(
      path: '$path/analysis_options.yaml',
      content:
          '# The analysis has been modified by FlutterPP in accordance with our recommendations.'
          '\n# Customize the adjustments as necessary for your project.',
      position: FileAppendPosition.top,
    );
  }
}
