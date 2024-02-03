import 'dart:io';

class BuildRunnerProvider {
  // create build yaml file
  Future<void> createBuildYaml(String path) async {
    String content = '''
    targets:
      \$default:
        builders:
          source_gen|combining_builder:
            generate_for:
              - lib/App/Models/**.dart
            options:
              build_extensions:
                "^lib/App/Models/{{}}.dart": "lib/App/Models/freezed/{{}}.g.dart"
          freezed|freezed:
            enabled: true
            options:
              build_extensions:
                "^lib/App/Models/{{}}.dart": "lib/App/Models/freezed/{{}}.freezed.dart"
    ''';

    // create file
    File file = File('$path/build.yaml');

    // write to file
    file.writeAsStringSync(content);
  }
}
