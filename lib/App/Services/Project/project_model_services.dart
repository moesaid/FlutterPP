import 'package:flutterpp/App/Models/model_config_model.dart';
import 'package:flutterpp/App/Providers/Network/Project/project_model_provider.dart';

class ProjectModelServices {
  ProjectModelProvider provider = ProjectModelProvider();

  // get project by id
  Future<List<ModelConfigModel>?> getProjectById({String? projectId}) async {
    return await provider.getProjectById(projectId: projectId);
  }
}
