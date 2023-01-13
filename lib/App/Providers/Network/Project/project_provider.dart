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
  Future<ProjectModel?> createProject({
    required String title,
    required String icon,
    required String color1,
    required String color2,
    required String teamId,
    required String description,
    String? cleintId,
  }) async {
    List<Map> data = await supabase.from('projects').insert([
      {
        'title': title,
        'description': description,
        'team_id': teamId,
        'client_id': cleintId,
        'admin_id': supabase.auth.currentUser!.id,
        'icon': icon,
        'color_1': color1,
        'color_2': color2,
        'created_at': DateTime.now().toIso8601String(),
      }
    ]).select();

    if (data.isEmpty) return null;
    var localJson = json.encode(data[0]);
    return ProjectModel.fromJson(json.decode(localJson));
  }

  // update project
  Future<ProjectModel?> updateProject({required ProjectModel project}) async {
    List<Map> data = await supabase
        .from('projects')
        .update(project.toJson())
        .eq('id', project.id)
        .select();

    if (data.isEmpty) return null;
    var localJson = json.encode(data[0]);
    return ProjectModel.fromJson(json.decode(localJson));
  }
}
