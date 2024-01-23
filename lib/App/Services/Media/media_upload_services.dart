import 'package:file_selector/file_selector.dart';
import 'package:flutterpp/App/Models/team_model.dart';
import 'package:flutterpp/App/Providers/Network/Media/media_upload_provider.dart';
import 'package:flutterpp/App/Services/Team/team_services.dart';

class MediaUploadServices {
  final MediaUploadProvider _provider = MediaUploadProvider();
  final TeamServices _teamServices = TeamServices();

  // upload file
  Future<String?> uploadFile({
    String? mockupId,
    required String bucketId,
    required XFile file,
  }) async {
    // get team
    final TeamModel? team = await _teamServices.getTeamForAuthUser();

    // get file name
    String fileName = _provider.getFileName(file: file);

    // upload
    String? path = await _provider.uploadFile(
      prefex: team!.name!,
      fileName: fileName,
      bucketId: bucketId,
      file: file,
    );

    if (path == null) return null;

    // get public url
    String? url = await _provider.getPublicUrl(
      bucketId: bucketId,
      path: '${team.name}/$fileName',
    );

    if (url == null) return null;

    // file size in megabytes
    int size = (await file.length()) ~/ 1000000;

    // create record
    await _provider.createRecord(
      teamId: team.id!,
      path: path,
      publicUrl: url,
      fileName: fileName,
      size: size,
      bucketId: bucketId,
      mockupId: mockupId,
    );

    return url;
  }
}
