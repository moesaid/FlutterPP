import 'package:file_selector/file_selector.dart';
import 'package:flutterpp/App/Models/media_model.dart';
import 'package:flutterpp/App/Providers/Device/file_maneger_provider.dart';
import 'package:flutterpp/App/Services/Media/media_upload_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:get/get.dart';

class SelectImageOptionController extends GetxController {
  // Get image
  getImage({
    String? mockupId,
    Function(String url)? callback,
    final Function(String, {bool? repeatForAll})? callbackForRepeat,
    bool? shouldRepeat,
  }) async {
    Get.showOverlay(
      asyncFunction: () async {
        XFile? res = await FileManegerProvider().pickFile(
          label: 'select image',
          extensions: ['jpg', 'png'],
        );

        if (res == null) return;

        MediaModel? item = await MediaUploadServices().uploadFile(
          file: res,
          bucketId: 'images',
          mockupId: mockupId,
        );

        if (item == null || item.publicUrl == null) return;

        if (shouldRepeat != null) {
          callbackForRepeat?.call(item.publicUrl!, repeatForAll: shouldRepeat);
          return;
        }

        callback?.call(item.publicUrl!);
      },
      loadingWidget: const BuildOverlay(),
    );
  }
}
