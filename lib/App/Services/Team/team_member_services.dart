import 'package:flutterpp/App/Models/team_member_model.dart';
import 'package:flutterpp/App/Providers/Network/Team/team_member_provider.dart';

class TeamMemberServices {
  TeamMemberProvider teamMemberProvider = TeamMemberProvider();

  // get team members
  Future<List<TeamMemberModel>?> getTeamMembers({
    required String teamId,
  }) async {
    return await teamMemberProvider.getTeamMembers(
      teamId: teamId,
    );
  }
}
