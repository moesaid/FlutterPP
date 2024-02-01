import 'package:flutterpp/App/Models/project_local_path_model.dart';
import 'package:flutterpp/App/Providers/Device/file_maneger_provider.dart';
import 'package:flutterpp/Storage/projects_local_path_storage.dart';

class CreateLoadProjectPathServices {
  final ProjectsLocalPathStorage projectsLocalPathStorage =
      ProjectsLocalPathStorage();
  final FileManegerProvider fileManegerProvider = FileManegerProvider();

  // load project path
  loadProjectPath({required String id}) async {
    String? path = await fileManegerProvider.userPickFileLocation();
    if (path == null) return;

    await projectsLocalPathStorage.write(
      project: ProjectLocalPathModel(
        id: id,
        path: path,
      ),
    );
  }

  // remove project path
  removeProjectPath({required String id}) async {
    await projectsLocalPathStorage.removeById(projectId: id);
  }
}
