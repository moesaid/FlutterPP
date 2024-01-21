import 'dart:convert';

import 'package:flutterpp/App/Models/team_member_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TeamMemberProvider {
  final supabase = Supabase.instance.client;

  // Get team members
  Future<List<TeamMemberModel>?> getTeamMembers(String teamId) async {
    List<Map> data = await supabase
        .from('members')
        .select('*')
        .eq('team_id', teamId)
        .select();

    if (data.isEmpty) return null;

    List<TeamMemberModel> members = [];
    for (var item in data) {
      var localJson = json.encode(item);
      members.add(TeamMemberModel.fromJson(json.decode(localJson)));
    }

    return members;
  }
}
