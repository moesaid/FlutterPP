import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class TeamProvider {
  final supabase = Supabase.instance.client;

  // check if user is in team
  Future<bool> isUserInTeam(String userId) async {
    return await supabase
        .from('members')
        .select('*')
        .eq('user_id', userId)
        .then((users) => users.isNotEmpty ? true : false);
  }

  // create team
  Future<List> createTeam({
    required String name,
    required String description,
  }) async {
    return await supabase.from('teams').insert([
      {
        'id': const Uuid().v4(),
        'name': name,
        'description': description,
        'admin_id': supabase.auth.currentUser!.id,
      }
    ]).select();
  }

  // link team member
  Future<List> linkTeamMember({
    required String teamId,
    required String userId,
  }) async {
    return await supabase.from('members').insert([
      {
        'id': const Uuid().v4(),
        'team_id': teamId,
        'user_id': userId,
      }
    ]).select();
  }
}
