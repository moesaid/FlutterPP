import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Providers/Network/project_provider.dart';
import 'package:flutterpp/App/Services/Global/call_pipeline.dart';

class ProjectServices {
  final CallPipeline _callPipeline = CallPipeline();
  final ProjectProvider _projectProvider = ProjectProvider();

  // get all projects by team id
  Future<List<ProjectModel>?> getProjects({required String teamId}) async {
    List<ProjectModel>? projects = await _callPipeline.futurePipeline(
      future: () => _projectProvider.getProjects(teamId: teamId),
      name: 'getProjects',
    );

    return projects;
  }
}
