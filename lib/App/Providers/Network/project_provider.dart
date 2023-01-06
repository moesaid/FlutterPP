import 'dart:convert';

import 'package:flutterpp/App/Models/project_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProjectProvider {
  // supabase
  final supabase = Supabase.instance.client;

  // get all projects by team id
  Future<List<ProjectModel>> getProjects({required String teamId}) async {
    List<Map> data = await supabase
        .from('projects')
        .select('*')
        .eq('team_id', teamId)
        .select();

    if (data.isEmpty) return [];

    List<ProjectModel> projects = [];
    for (var item in data) {
      var localJson = json.encode(item);
      projects.add(ProjectModel.fromJson(json.decode(localJson)));
    }

    return projects;
  }

  // create project
  Future<void> createProject({
    required String name,
    required String teamId,
    required String description,
  }) async {
    await supabase.from('projects').insert([
      {
        'name': name,
        'description': description,
        'team_id': teamId,
      }
    ]).select();
  }
}
