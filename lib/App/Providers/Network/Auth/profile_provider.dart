import 'dart:convert';

import 'package:flutterpp/App/Models/profile_model.dart';
import 'package:flutterpp/App/Services/Global/call_pipeline.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileProvider {
  final supabase = Supabase.instance.client;
  CallPipeline callPipeline = CallPipeline();

  // get auth profile
  Future<ProfileModel?> getAuthProfile() async {
    List<Map>? data = await callPipeline.futurePipeline(
      future: () async {
        return await supabase
            .from('profiles')
            .select('*')
            .eq('id', supabase.auth.currentUser!.id)
            .select();
      },
      name: 'get auth profile',
    );

    if (data == null || data.isEmpty) return null;

    var localJson = json.encode(data[0]);

    return ProfileModel.fromJson(json.decode(localJson));
  }
}
