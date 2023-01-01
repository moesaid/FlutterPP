import 'package:flutterpp/App/Providers/Network/team_provider.dart';
import 'package:flutterpp/App/Services/call_pipeline.dart';

class TeamServices {
  final CallPipeline _callPipeline = CallPipeline();
  final TeamProvider _teamProvider = TeamProvider();

  // check if user is in team
  Future<bool> isUserInTeam(String userId) async {
    bool? isInTeam = await _callPipeline.futurePipeline(
      future: () => _teamProvider.isUserInTeam(userId),
      name: 'isUserInTeam',
    );

    return isInTeam!;
  }

  // create team and link team member
  Future<bool> createTeam({
    required String name,
    required String description,
  }) async {
    List? team = await _callPipeline.futurePipeline(
      future: () => _teamProvider.createTeam(
        name: name,
        description: description,
      ),
      name: 'createTeam',
    );

    if (team == null || team.isEmpty) return false;

    // link team
    List? members = await _callPipeline.futurePipeline(
      future: () => _teamProvider.linkTeamMember(
        teamId: team.first['id'],
        userId: team.first['admin_id'],
      ),
      name: 'linkTeamMember',
    );

    if (members == null || members.isEmpty) return false;

    return true;
  }
}
