import 'package:supabase_flutter/supabase_flutter.dart';

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
}
