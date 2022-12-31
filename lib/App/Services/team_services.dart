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
}
