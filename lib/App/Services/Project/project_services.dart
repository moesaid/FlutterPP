import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Providers/Network/Project/project_provider.dart';
import 'package:flutterpp/App/Services/Global/call_pipeline.dart';

class ProjectServices {
  final CallPipeline _callPipeline = CallPipeline();
  final ProjectProvider _projectProvider = ProjectProvider();

  // get project by id
  Future<ProjectModel?> getProjectById({required String projectId}) async {
    return await _callPipeline.futurePipeline(
      future: () => _projectProvider.getProjectById(projectId: projectId),
      name: 'getProjectById',
    );
  }

  // get all projects by team id
  Future<List<ProjectModel>?> getProjects({required String teamId}) async {
    List<ProjectModel>? projects = await _callPipeline.futurePipeline(
      future: () => _projectProvider.getProjects(teamId: teamId),
      name: 'getProjects',
    );

    return projects;
  }

  // create project
  Future<ProjectModel?> createProject({
    required String title,
    required String icon,
    required String color1,
    required String color2,
    required String teamId,
    required String description,
    required String stateManagement,
    String? cleintId,
  }) async {
    return await _callPipeline.futurePipeline(
      future: () => _projectProvider.createProject(
        title: title,
        icon: icon,
        color1: color1,
        color2: color2,
        teamId: teamId,
        description: description,
        cleintId: cleintId,
        stateManagement: stateManagement,
      ),
      name: 'createProject',
    );
  }

  // update project
  Future<ProjectModel?> updateProject({required ProjectModel project}) async {
    return await _callPipeline.futurePipeline(
      future: () => _projectProvider.updateProject(project: project),
      name: 'updateProject',
    );
  }

  // delete project
  Future<void> deleteProject({required String projectId}) async {
    return await _callPipeline.futurePipeline(
      future: () => _projectProvider.deleteProject(projectId: projectId),
      name: 'deleteProject',
    );
  }
}
