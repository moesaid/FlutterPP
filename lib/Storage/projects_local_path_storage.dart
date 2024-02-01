import 'package:flutterpp/App/Models/project_local_path_model.dart';
import 'package:get_storage/get_storage.dart';

class ProjectsLocalPathStorage {
  // box
  final GetStorage _box = GetStorage();

  // key
  final String _key = 'projects_local_path';

  // read all
  List<ProjectLocalPathModel> readAll() {
    List<ProjectLocalPathModel> projects = [];
    List<dynamic> data = _box.read(_key) ?? [];
    for (var item in data) {
      projects.add(ProjectLocalPathModel.fromJson(item));
    }
    return projects;
  }

  // read by id
  ProjectLocalPathModel? readById({required String projectId}) {
    List<ProjectLocalPathModel> projects = readAll();
    return projects.firstWhere(
      (element) => element.id == projectId,
      orElse: () => ProjectLocalPathModel(),
    );
  }

  // write
  Future<ProjectLocalPathModel> write({
    required ProjectLocalPathModel project,
  }) async {
    List<ProjectLocalPathModel> projects = readAll();
    projects.removeWhere((element) => element.id == project.id);
    projects.add(project);

    //  write as json
    await _box.write(_key, projects.map((e) => e.toJson()).toList());

    return project;
  }

  // remove all
  Future<void> remove() async {
    await _box.remove(_key);
  }
}
