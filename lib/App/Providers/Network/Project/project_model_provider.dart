import 'dart:convert';

import 'package:flutterpp/App/Models/model_config_model.dart';
import 'package:flutterpp/App/Services/Global/call_pipeline.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProjectModelProvider {
  final CallPipeline _callPipeline = CallPipeline();
  final supabase = Supabase.instance.client;

  // get project by id
  Future<List<ModelConfigModel>?> getProjectById({String? projectId}) async {
    print('❌projectId: $projectId');

    if (projectId == null || projectId.isEmpty) return null;

    return await _callPipeline.futurePipeline(
      future: () async {
        List<Map> data = await supabase
            .from('project_models')
            .select('*')
            // .eq('project_id', projectId)
            .select();

        if (data.isEmpty) return null;

        // var localJson = json.encode(data[0]);

        final List<ModelConfigModel> models = [];
        for (var item in data) {
          var localJson = json.encode(item);
          models.add(ModelConfigModel.fromJson(json.decode(localJson)));
        }

        return models;
      },
      name: 'getProjectById',
    );
  }
}
