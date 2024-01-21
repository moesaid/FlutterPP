import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Models/team_model.dart';
import 'package:flutterpp/App/Services/Project/project_services.dart';
import 'package:flutterpp/App/Services/Team/team_services.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final _teamServices = TeamServices();
  final _projectServices = ProjectServices();

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _team = TeamModel().obs;
  TeamModel get team => _team.value;

  final _projects = <ProjectModel>[].obs;
  List<ProjectModel> get projects => _projects;

  final _activeProject = ProjectModel().obs;
  ProjectModel get activeProject => _activeProject.value;

  @override
  Future<void> onInit() async {
    await _fetchTeamAndProjects();
    super.onInit();
  }

  // fetch team and projects
  Future<void> _fetchTeamAndProjects() async {
    TeamModel? team = await _teamServices.getTeamForAuthUser();

    if (team == null || team.id == null) return;

    List<ProjectModel>? projects = await _projectServices.getProjects(
      teamId: team.id!,
    );

    _team.value = team;

    if (projects == null || projects.isEmpty) return;

    _projects.value = projects;
    _activeProject.value = projects.first;
    _isLoading.value = false;
    update();
  }
}
