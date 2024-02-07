import 'dart:convert';

import 'package:flutterpp/App/Models/model_config_model.dart';
import 'package:flutterpp/App/Services/Global/call_pipeline.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProjectModelProvider {
  final CallPipeline _callPipeline = CallPipeline();
  final supabase = Supabase.instance.client;

  // get project by id
  Future<List<ModelConfigModel>?> getProjectById({String? projectId}) async {
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

  // create project model
  Future<ModelConfigModel?> createProjectModel({
    required ModelConfigModel model,
  }) async {
    return await _callPipeline.futurePipeline(
      future: () async {
        var data = await supabase.from('project_models').insert({
          'model_name': model.modelName,
          'color': model.color,
          'is_crud': model.isCrud ?? false,
          'project_id': model.projectId,
          'properties': model.properties,
          'relations': model.relations,
        }).select();

        if (data.isEmpty) return null;

        var localJson = json.encode(data[0]);
        return ModelConfigModel.fromJson(json.decode(localJson));
      },
      name: 'createProjectModel',
    );
  }

  // update project model
  Future<ModelConfigModel?> updateProjectModel({
    required ModelConfigModel model,
  }) async {
    return await _callPipeline.futurePipeline(
      future: () async {
        var data = await supabase
            .from('project_models')
            .update(model.toJson())
            .eq('id', model.id!)
            .select();

        if (data.isEmpty) return null;

        var localJson = json.encode(data[0]);
        return ModelConfigModel.fromJson(json.decode(localJson));
      },
      name: 'updateProjectModel',
    );
  }

  // delete project model
  Future<void> deleteProjectModel({required String modelId}) async {
    print({'❌modelId': modelId});

    await _callPipeline.futurePipeline(
      future: () async {
        var err =
            await supabase.from('project_models').delete().eq('id', modelId);
        print(err);
      },
      name: 'deleteProjectModel',
    );
  }
}
