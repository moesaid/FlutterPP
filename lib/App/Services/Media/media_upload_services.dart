import 'package:file_selector/file_selector.dart';
import 'package:flutterpp/App/Providers/Network/Media/media_upload_provider.dart';

class MediaUploadServices {
  final MediaUploadProvider _provider = MediaUploadProvider();

  // upload file
  Future<String?> uploadFile({
    required String bucketId,
    required XFile file,
  }) async {
    // get file name
    String fileName = _provider.getFileName(file: file);

    // upload
    String? path = await _provider.uploadFile(
        bucketId: bucketId, file: file, fileName: fileName);

    if (path == null) return null;

    // get public url
    String? url = await _provider.getPublicUrl(
      bucketId: bucketId,
      path: fileName,
    );

    return url;
  }
}
