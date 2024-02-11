import 'package:file_selector/file_selector.dart';
import 'package:flutterpp/App/Models/media_model.dart';
import 'package:flutterpp/App/Models/team_model.dart';
import 'package:flutterpp/App/Providers/Network/Media/media_upload_provider.dart';
import 'package:flutterpp/App/Services/Team/team_services.dart';
import 'package:flutterpp/App/Views/Global/build_snackbar.dart';

class MediaUploadServices {
  final MediaUploadProvider _provider = MediaUploadProvider();
  final TeamServices _teamServices = TeamServices();

  // upload file
  Future<MediaModel?> uploadFile({
    String? mockupId,
    required String bucketId,
    required XFile file,
  }) async {
    // get team
    final TeamModel? team = await _teamServices.getTeamForAuthUser();

    // get file name
    String fileName = _provider.getFileName(file: file);

    // file size in kb
    int size = (await file.length()) ~/ 1024 + 1;

    // original file name
    String originalFileName = file.name;

    // if size is greater than 10mb
    if (size > 10240) {
      BuildSnackBar(
        title: 'Oops!',
        message: 'File size should be less than 10mb',
      ).error();
      return null;
    }

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

    // create record
    return await _provider.createRecord(
      teamId: team.id!,
      path: path,
      publicUrl: url,
      fileName: originalFileName,
      size: size,
      bucketId: bucketId,
      mockupId: mockupId,
      type: file.name.split('.').last,
    );
  }

  // get media by team id
  Future<List<MediaModel>?> getMediaByTeamId() async {
    // get team
    final TeamModel? team = await _teamServices.getTeamForAuthUser();

    if (team == null || team.id == null) return null;

    return await _provider.getMediaRecordsByTeamId(
      teamId: team.id!,
    );
  }
}
