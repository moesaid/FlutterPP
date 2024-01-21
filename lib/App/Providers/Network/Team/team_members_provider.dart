import 'package:supabase_flutter/supabase_flutter.dart';

class TeamMembersProvider {
  final supabase = Supabase.instance.client;

  // Get team members
  Future<List> getTeamMembers(String teamId) async {
    return await supabase.from('members').select().eq('team_id', teamId);
  }
}
