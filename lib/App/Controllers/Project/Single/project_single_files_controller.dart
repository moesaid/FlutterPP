import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterpp/App/Models/media_model.dart';
import 'package:flutterpp/App/Providers/Device/file_maneger_provider.dart';
import 'package:flutterpp/App/Services/Media/media_upload_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:flutterpp/App/Views/Global/build_snackbar.dart';
import 'package:get/get.dart';

class ProjectSingleFilesController extends GetxController {
  final FileManegerProvider _fileManegerProvider = FileManegerProvider();
  final MediaUploadServices _mediaUploadServices = MediaUploadServices();

  final _mediaSize = 0.obs;
  int get mediaSize => _mediaSize.value;

  final _documentsSize = 0.obs;
  int get documentsSize => _documentsSize.value;

  final _compressedSize = 0.obs;
  int get compressedSize => _compressedSize.value;

  final _otherSize = 0.obs;
  int get otherSize => _otherSize.value;

  final _totalSize = 256000.obs;
  int get totalSize => _totalSize.value;

  final _usedSize = 0.obs;
  int get usedSize => _usedSize.value;

  final _usedPercentage = 0.0.obs;
  double get usedPercentage => _usedPercentage.value;

  final _allowedExtensions = <String>[
    'jpg',
    'png',
    'jpeg',
    'gif',
    'svg',
    'pdf',
    'doc',
    'docx',
    'xls',
    'xlsx',
    'ppt',
    'pptx',
    'txt',
    'csv',
    'json',
    'xml',
    'zip',
    'rar',
    'psd',
  ].obs;
  List<String> get allowedExtensions => _allowedExtensions;

  final _files = <MediaModel>[].obs;
  List<MediaModel> get files => _files;

  final _searchResults = <MediaModel>[].obs;
  List<MediaModel> get searchResults => _searchResults;

  final _searchKey = ''.obs;
  String get searchKey => _searchKey.value;

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  @override
  Future<void> onInit() async {
    await _getTeamFiles();
    updateLoading(false);
    super.onInit();
  }

  // upload file
  Future<void> uploadFile() async {
    XFile? file = await _fileManegerProvider.pickFile(
      extensions: _allowedExtensions,
    );

    if (file == null) return;

    // if the used size plus the file size is greater than the total size
    if (_usedSize.value + (await file.length()) ~/ 1024 + 1 >=
        _totalSize.value) {
      BuildSnackBar(
        title: 'Oops!',
        message: 'You have reached the maximum limit of 250mb',
      ).error();
      return;
    }

    await Get.showOverlay(
      asyncFunction: () async {
        MediaModel? res = await _mediaUploadServices.uploadFile(
          bucketId: 'teams',
          file: file,
        );

        if (res == null) return;

        _files.add(res);
        calculateSidebarNumbers();
        update();
      },
      loadingWidget: const BuildOverlay(),
    );
  }

  // get team files
  Future<void> _getTeamFiles() async {
    List<MediaModel>? items = await _mediaUploadServices.getMediaByTeamId();

    if (items == null) return;

    _files.assignAll(items);

    // sum all item.size
    calculateSidebarNumbers();
  }

  // calculate sidebar numbers
  void calculateSidebarNumbers() {
    int mediaSize = 0;
    int documentsSize = 0;
    int compressedSize = 0;
    int otherSize = 0;

    for (var item in _files) {
      if (item.type == 'jpg' ||
          item.type == 'png' ||
          item.type == 'jpeg' ||
          item.type == 'gif' ||
          item.type == 'svg') {
        mediaSize += item.size ?? 0;
      } else if (item.type == 'pdf' ||
          item.type == 'doc' ||
          item.type == 'docx' ||
          item.type == 'xls' ||
          item.type == 'xlsx' ||
          item.type == 'ppt' ||
          item.type == 'pptx' ||
          item.type == 'txt' ||
          item.type == 'csv' ||
          item.type == 'json' ||
          item.type == 'xml') {
        documentsSize += item.size ?? 0;
      } else if (item.type == 'zip' || item.type == 'rar') {
        compressedSize += item.size ?? 0;
      } else {
        otherSize += item.size ?? 0;
      }
    }

    _mediaSize.value = mediaSize;
    _documentsSize.value = documentsSize;
    _compressedSize.value = compressedSize;
    _otherSize.value = otherSize;

    _usedSize.value = mediaSize + documentsSize + compressedSize;
    _usedPercentage.value = (_usedSize.value / _totalSize.value) * 100;
  }

  // update loading
  void updateLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  // search files
  void searchFiles(String value) {
    _searchKey.value = value;

    if (value.isEmpty) {
      _searchResults.clear();
      return;
    }

    _searchResults.assignAll(
      _files.where(
        (item) => item.fileName!.toLowerCase().contains(value.toLowerCase()),
      ),
    );

    update();
  }

  // clear search
  void clearSearch() {
    _searchKey.value = '';
    _searchResults.clear();
    update();
  }

  // rename media
  Future<void> renameMedia(MediaModel? item, String? value) async {
    if (item == null || value == null) return;

    await Get.showOverlay(
      asyncFunction: () async {
        await _mediaUploadServices.renameMedia(
          mediaId: item.id!,
          newName: '$value.${item.type!}',
        );

        await _getTeamFiles();
        updateLoading(false);
      },
      loadingWidget: const BuildOverlay(),
    );
  }

  // remove media
  Future<void> removeMedia(String? id, String? path) async {
    if (id == null || path == null) return;

    await Get.showOverlay(
      asyncFunction: () async {
        await _mediaUploadServices.removeMedia(
          mediaId: id,
          path: path,
        );

        await _getTeamFiles();
        calculateSidebarNumbers();
        update();
      },
      loadingWidget: const BuildOverlay(),
    );
  }

  // download file
  Future<void> downloadFile(MediaModel item) async {
    if (item.path == null || item.type == null) return;

    Uint8List? bytes = await Get.showOverlay(
      asyncFunction: () async {
        // get downloaded file
        return await _mediaUploadServices.downloadFile(
          from: 'teams',
          path: item.path!,
        );
      },
      loadingWidget: const BuildOverlay(),
    );

    if (bytes == null) return;

    print(item.type);

    await _fileManegerProvider.saveFileWithoutLocation(
      fileName: item.fileName!,
      fileExtension: item.type!,
      bytes: bytes,
    );
  }
}
