import 'package:flutterpp/App/Models/project_model.dart';
import 'package:get_storage/get_storage.dart';

class ActiveProjectStorage {
  // int box
  GetStorage box = GetStorage();

  final String key = 'activeProject';

  // read active project
  ProjectModel? read() {
    // read json from box
    var json = box.read(key);

    // if json is null return null
    if (json == null) return null;

    // return project model from json
    return ProjectModel.fromJson(json);
  }

  // write active project
  Future<ProjectModel> write(ProjectModel project) async {
    // write json to box
    await box.write(key, project.toJson());

    // return project
    return read()!;
  }
}
