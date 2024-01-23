import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutterpp/App/Services/Global/call_pipeline.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class MediaUploadProvider {
  final supabase = Supabase.instance.client;
  CallPipeline callPipeline = CallPipeline();

  // upload image
  Future<String?> uploadFile({
    required XFile file,
    required String bucketId,
    required String fileName,
    required String prefex,
  }) async {
    return await callPipeline.futurePipeline(
      future: () async {
        // xfile to file
        File localFile = File(file.path);

        return await supabase.storage.from(bucketId).upload(
              '$prefex/$fileName',
              localFile,
            );
      },
      name: 'upload image',
    );
  }

  // get public url
  Future<String?> getPublicUrl({
    required String path,
    required String bucketId,
  }) async {
    return await callPipeline.futurePipeline(
      future: () async {
        return await supabase.storage
            .from(bucketId)
            .createSignedUrl(path, 60 * 60 * 24 * 365 * 10);
      },
      name: 'get public url',
    );
  }

  // get file name
  getFileName({required XFile file}) {
    return '${DateTime.now().millisecondsSinceEpoch}${const Uuid().v4()}.${file.path.split('.').last}';
  }

  // create record
  Future<List<Map>?> createRecord({
    required String teamId,
    required String bucketId,
    required String path,
    required String fileName,
    required String publicUrl,
    required int size,
    String? mockupId,
  }) async {
    return await callPipeline.futurePipeline(
      future: () async {
        List<Map> data = await supabase.from('media').insert([
          {
            'bucket_id': bucketId,
            'path': path,
            'file_name': fileName,
            'public_url': publicUrl,
            'size': size,
            'team_id': teamId,
            if (mockupId != null) 'mockup_id': mockupId,
          }
        ]).select();

        if (data.isEmpty) return null;
        return data;
      },
      name: 'create record',
    );
  }
}
