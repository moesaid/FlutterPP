import 'dart:convert';
import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterpp/App/Models/media_model.dart';
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
  Future<MediaModel?> createRecord({
    required String teamId,
    required String bucketId,
    required String path,
    required String fileName,
    required String publicUrl,
    required String type,
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
            'type': type,
            if (mockupId != null) 'mockup_id': mockupId,
          }
        ]).select();

        if (data.isEmpty) return null;

        var localJson = json.encode(data[0]);
        return MediaModel.fromJson(json.decode(localJson));
      },
      name: 'create record',
    );
  }

  // get media records by team id
  Future<List<MediaModel>?> getMediaRecordsByTeamId({
    required String teamId,
  }) async {
    return await callPipeline.futurePipeline(
      future: () async {
        List<Map> data = await supabase
            .from('media')
            .select('*')
            .eq('team_id', teamId)
            .select();

        if (data.isEmpty) return null;

        List<MediaModel> items = data.map((e) {
          var localJson = json.encode(e);
          return MediaModel.fromJson(json.decode(localJson));
        }).toList();

        return items;
      },
      name: 'get media records by team id',
    );
  }

  // list files
  Future<List<Map>?> listFiles({required String bucketId}) async {
    return await callPipeline.futurePipeline(
      future: () async {
        List<FileObject> data = await supabase.storage.from('teams').list(
              path: bucketId,
              searchOptions: const SearchOptions(
                limit: 100,
                offset: 0,
                sortBy: SortBy(
                  column: 'name',
                  order: 'asc',
                ),
              ),
            );

        if (data.isEmpty) return null;

        return null;
      },
      name: 'list files',
    );
  }

  // rename record
  Future<MediaModel?> renameRecord({
    required String id,
    required String fileName,
  }) async {
    return await callPipeline.futurePipeline(
      future: () async {
        List<Map> data = await supabase
            .from('media')
            .update({'file_name': fileName})
            .eq('id', id)
            .select();

        if (data.isEmpty) return null;

        var localJson = json.encode(data[0]);
        return MediaModel.fromJson(json.decode(localJson));
      },
      name: 'rename record',
    );
  }

  // remove record
  Future<void> removeRecord({required String id}) async {
    await callPipeline.futurePipeline(
      future: () async {
        await supabase.from('media').delete().eq('id', id);
      },
      name: 'remove record',
    );
  }

  // remove file
  Future<void> removeFile({
    required String from,
    required String path,
  }) async {
    await callPipeline.futurePipeline(
      future: () async {
        await supabase.storage.from(from).remove([
          path,
        ]);
      },
      name: 'remove file',
    );
  }

  // download file
  Future<Uint8List?> downloadFile({
    required String from,
    required String path,
  }) async {
    return await callPipeline.futurePipeline(
      future: () async {
        Uint8List? res = await supabase.storage.from(from).download(path);

        return res;
      },
      name: 'download file',
    );
  }
}
