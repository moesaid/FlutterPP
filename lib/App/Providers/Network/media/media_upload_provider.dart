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
  }) async {
    return await callPipeline.futurePipeline(
      future: () async {
        // xfile to file
        File localFile = File(file.path);

        return await supabase.storage.from(bucketId).upload(
              fileName,
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
    print({
      '❌path': path,
      'bucketId': bucketId,
    });
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
}
