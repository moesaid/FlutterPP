import 'package:file_selector/file_selector.dart';
import 'package:flutterpp/App/Providers/Device/file_maneger_provider.dart';
import 'package:flutterpp/App/Services/Media/media_upload_services.dart';
import 'package:get/get.dart';

class SelectImageOptionController extends GetxController {
  // Get image
  getImage({
    String? mockupId,
    Function(String url)? callback,
  }) async {
    XFile? res = await FileManegerProvider().pickFile(
      label: 'select image',
      extensions: ['jpg', 'png'],
    );

    String? url = await MediaUploadServices().uploadFile(
      file: res!,
      bucketId: 'images',
      mockupId: mockupId,
    );

    if (url == null) return;

    callback?.call(url);
  }
}
