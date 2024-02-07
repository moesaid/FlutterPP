import 'package:flutterpp/App/Models/model_config_model.dart';
import 'package:flutterpp/App/Providers/Network/Project/project_model_provider.dart';

class ProjectModelServices {
  ProjectModelProvider provider = ProjectModelProvider();

  // get project by id
  Future<List<ModelConfigModel>?> getProjectById({String? projectId}) async {
    return await provider.getProjectById(projectId: projectId);
  }

  // create project model
  Future<ModelConfigModel?> createProjectModel({
    required ModelConfigModel model,
  }) async {
    return await provider.createProjectModel(model: model);
  }

  // update project model
  Future<ModelConfigModel?> updateProjectModel({
    required ModelConfigModel model,
  }) async {
    return await provider.updateProjectModel(model: model);
  }

  // delete project model
  Future<void> deleteProjectModel({required String modelId}) async {
    return await provider.deleteProjectModel(modelId: modelId);
  }
}
