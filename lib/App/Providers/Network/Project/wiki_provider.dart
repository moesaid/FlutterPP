import 'dart:convert';

import 'package:flutterpp/App/Models/wiki_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WikiProvider {
  // supabase
  final supabase = Supabase.instance.client;

  // get wiki by project id
  Future<WikiModel?> getWiki({required int projectId}) async {
    List<Map> data = await supabase
        .from('wikis')
        .select('*')
        .eq('project_id', projectId)
        .select();

    if (data.isEmpty) return null;

    var localJson = json.encode(data[0]);
    return WikiModel.fromJson(json.decode(localJson));
  }

  // create wiki
  Future<WikiModel?> createWiki({
    required String document,
    required int projectId,
  }) async {
    List<Map> data = await supabase.from('wikis').insert([
      {
        'document': document,
        'project_id': projectId,
        'created_at': DateTime.now().toIso8601String(),
      }
    ]).select();

    if (data.isEmpty) return null;
    var localJson = json.encode(data[0]);
    return WikiModel.fromJson(json.decode(localJson));
  }

  // update wiki
  Future<WikiModel?> updateWiki({required WikiModel wiki}) async {
    List<Map> data = await supabase
        .from('wikis')
        .update({
          'document': wiki.document,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', wiki.id!)
        .select();

    if (data.isEmpty) return null;
    var localJson = json.encode(data[0]);
    return WikiModel.fromJson(json.decode(localJson));
  }
}
