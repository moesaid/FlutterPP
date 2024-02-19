import 'dart:convert';

import 'package:flutterpp/App/Models/mockup_model.dart';
import 'package:flutterpp/App/Services/Global/call_pipeline.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockupProvider {
  final CallPipeline _callPipeline = CallPipeline();
  final supabase = Supabase.instance.client;

  // get mockup by id
  Future<MockupModel?> getMockupById({required String mockupId}) async {
    List<Map> data =
        await supabase.from('mockups').select('*').eq('id', mockupId).select();

    if (data.isEmpty) return null;

    var localJson = json.encode(data[0]);
    return MockupModel.fromJson(json.decode(localJson));
  }

  // get all mockups by project id
  Future<List<MockupModel>?> getByProjectId({required String projectId}) async {
    List<Map> data = await supabase
        .from('mockups')
        .select('*')
        .eq('project_id', projectId)
        .order('created_at', ascending: true)
        .select();

    if (data.isEmpty) return null;

    List<MockupModel> mockups = [];
    for (var item in data) {
      var localJson = json.encode(item);
      mockups.add(MockupModel.fromJson(json.decode(localJson)));
    }

    return mockups;
  }

  // get mockup by team id
  Future<List<MockupModel>?> getByTeamId({required String teamId}) async {
    List<Map> data = await supabase
        .from('mockups')
        .select('*')
        .eq('team_id', teamId)
        .order('created_at', ascending: true)
        .select();

    if (data.isEmpty) return null;

    List<MockupModel> mockups = [];
    for (var item in data) {
      var localJson = json.encode(item);
      mockups.add(MockupModel.fromJson(json.decode(localJson)));
    }

    return mockups;
  }

  // get mockup by team and project id
  Future<List<MockupModel>?> getByTeamAndProjectId(
      {required String teamId, required String projectId}) async {
    List<Map> data = await supabase
        .from('mockups')
        .select('*')
        .eq('team_id', teamId)
        .eq('project_id', projectId)
        .order('created_at', ascending: true)
        .select();

    if (data.isEmpty) return null;

    List<MockupModel> mockups = [];
    for (var item in data) {
      var localJson = json.encode(item);
      mockups.add(MockupModel.fromJson(json.decode(localJson)));
    }

    return mockups;
  }

  // create mockup
  Future<MockupModel?> createMockup({
    required MockupModel item,
  }) async {
    print(item.toMap());

    List<Map>? data = await _callPipeline.futurePipeline(
      future: () => supabase.from('mockups').insert([
        item.toMap(),
      ]).select(),
      name: 'create mockup',
    );

    if (data == null || data.isEmpty) return null;
    var localJson = json.encode(data[0]);

    print(localJson);

    return MockupModel.fromJson(json.decode(localJson));
  }

  // update mockup
  Future<MockupModel?> updateMockup({required MockupModel item}) async {
    List<Map> data = await supabase
        .from('mockups')
        .update(item.toMap())
        .eq('id', item.id!)
        .select();

    if (data.isEmpty) return null;
    var localJson = json.encode(data[0]);
    return MockupModel.fromJson(json.decode(localJson));
  }

  // delete mockup
  Future<bool> deleteMockup({required String mockupId}) async {
    try {
      await supabase.from('mockups').delete().eq('id', mockupId);
    } catch (e) {
      print(e);
      return false;
    }

    return true;
  }
}
