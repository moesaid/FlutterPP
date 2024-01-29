import 'dart:typed_data';

import 'package:device_frame/device_frame.dart';
import 'package:flutterpp/App/Models/template_config_model.dart';
import 'package:flutterpp/App/Providers/Device/file_maneger_provider.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_device_card.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as IMG;
import 'package:image/image.dart';
import 'package:screenshot/screenshot.dart';

class MockupExportServices {
  FileManegerProvider fileManegerProvider = FileManegerProvider();

  // Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  // screenshot
  Future<Uint8List> takeScreenshot(
    TemplateConfigModel item, {
    DeviceInfo? device,
    double? width,
    double? height,
  }) async {
    screenshotController.capture(delay: const Duration(milliseconds: 10));

    return await screenshotController.captureFromWidget(
      BuildDeviceBody(
        config: item,
        device: device,
        width: width ?? 430,
        height: height ?? 932,
      ),
      context: Get.context!,
      delay: const Duration(seconds: 1),
      pixelRatio: 4,
    );
  }

  // export
  Future<void> export({required List<TemplateConfigModel> items}) async {
    // get path
    String? path = await fileManegerProvider.userPickFileLocation();

    if (path == null) return;

    String folderName = 'FlutterPP Screenshots';
    String homePath = '$path/$folderName/';
    String ios = '$homePath/ios/';
    String ios67 = '$ios/Apple_iphone_(1290x2796)';
    String ios65 = '$ios/Apple_iphone_(1284x2778)';
    String ios55 = '$ios/Apple_iphone_(1242x2208)';
    String iosIpad = '$ios/Apple_ipad_(2048x2732)';
    String android = '$homePath/android/';

    await createFolders(
      path: path,
      folderName: folderName,
      androidFolders: ['phone', 'ipad_7_inch', 'ipad_10_inch'],
      iosFolders: [
        'Apple_iphone_(1290x2796)',
        'Apple_iphone_(1284x2778)',
        'Apple_iphone_(1242x2208)',
        'Apple_ipad_(2048x2732)',
      ],
    );

    // // pre images
    List<Uint8List> preImages = [];
    List<Uint8List> preIos67Image = [];
    List<Uint8List> preIos55Images = [];
    List<Uint8List> preIosIpadImages = [];
    List<Uint8List> preGalaxyImages = [];
    List<Uint8List> preGalaxyIpad7Images = [];
    List<Uint8List> preGalaxyIpad10Images = [];

    // screenshot original images
    for (var item in items) {
      Uint8List local = await takeScreenshot(item, width: 321, height: 694.5);
      preImages.add(local);

      Uint8List localIos67Image = await takeScreenshot(
        item,
        width: 322.5,
        height: 699,
      );
      preIos67Image.add(localIos67Image);

      Uint8List localIos55 = await takeScreenshot(
        item,
        width: 310.5,
        height: 552,
        device: Devices.ios.iPhoneSE,
      );
      preIos55Images.add(localIos55);

      Uint8List localIosIpadImages = await takeScreenshot(
        item,
        width: 512,
        height: 683,
        device: Devices.ios.iPadPro11Inches,
      );
      preIosIpadImages.add(localIosIpadImages);

      Uint8List localGalaxyImages = await takeScreenshot(
        item,
        width: 270 * 2,
        height: 480 * 2,
        device: Devices.android.samsungGalaxyS20,
      );
      preGalaxyImages.add(localGalaxyImages);

      Uint8List localGalaxyIpadImages = await takeScreenshot(
        item,
        width: 270 * 2,
        height: 480 * 2,
        device: Devices.android.smallTablet,
      );
      preGalaxyIpad7Images.add(localGalaxyIpadImages);

      Uint8List localGalaxyIpadImages10 = await takeScreenshot(
        item,
        width: 270 * 2,
        height: 480 * 2,
        device: Devices.android.largeTablet,
      );
      preGalaxyIpad10Images.add(localGalaxyIpadImages10);
    }

    // save ios67 images
    for (var i = 0; i < preImages.length; i++) {
      Uint8List? ios67Image = await resizeImage(preIos67Image[i], 1290, 2796);
      Uint8List? ios65Image = await resizeImage(preImages[i], 1284, 2778);

      await fileManegerProvider.saveFile(
        fileName: 'image_$i',
        fileExtension: 'jpg',
        location: ios67,
        bytes: ios67Image,
      );

      await fileManegerProvider.saveFile(
        fileName: 'image_$i',
        fileExtension: 'jpg',
        location: ios65,
        bytes: ios65Image,
      );
    }

    // save ios55 images
    for (var i = 0; i < preIos55Images.length; i++) {
      Uint8List? ios55Image = await resizeImage(preIos55Images[i], 1242, 2208);

      await fileManegerProvider.saveFile(
        fileName: 'image_$i',
        fileExtension: 'jpg',
        location: ios55,
        bytes: ios55Image,
      );
    }

    // save iosIpad images
    for (var i = 0; i < preIosIpadImages.length; i++) {
      Uint8List? iosIpadImage =
          await resizeImage(preIosIpadImages[i], 2048, 2732);

      await fileManegerProvider.saveFile(
        fileName: 'image_$i',
        fileExtension: 'jpg',
        location: iosIpad,
        bytes: iosIpadImage,
      );
    }

    // save android images
    for (var i = 0; i < preGalaxyImages.length; i++) {
      await fileManegerProvider.saveFile(
        fileName: 'image_$i',
        fileExtension: 'jpg',
        location: '$android/phone',
        bytes: preGalaxyImages[i],
      );

      await fileManegerProvider.saveFile(
        fileName: 'image_$i',
        fileExtension: 'jpg',
        location: '$android/ipad_7_inch',
        bytes: preGalaxyIpad7Images[i],
      );

      await fileManegerProvider.saveFile(
        fileName: 'image_$i',
        fileExtension: 'jpg',
        location: '$android/ipad_10_inch',
        bytes: preGalaxyIpad10Images[i],
      );
    }
  }

  // resize image
  Future<Uint8List?> resizeImage(Uint8List data, width, height) async {
    final com = Command()
      ..decodeImage(data)
      ..copyResize(
        width: width,
        height: height,
        interpolation: Interpolation.nearest,
      )
      ..encodeJpg();

    return IMG.executeCommandBytes(com);
  }

  // create folders
  Future<void> createFolders({
    required String path,
    required String folderName,
    List<String>? iosFolders,
    List<String>? androidFolders,
  }) async {
    // create new folder

    String homePath = '$path/$folderName/';

    // save locations
    String ios = '$homePath/ios/';
    String android = '$homePath/android/';

    // create folder
    await fileManegerProvider.createFolder(
      location: path,
      folderName: folderName,
    );

    await fileManegerProvider.createFolder(
      location: homePath,
      folderName: 'ios',
    );

    await fileManegerProvider.createFolder(
      location: homePath,
      folderName: 'android',
    );

    if (androidFolders != null) {
      for (var i = 0; i < androidFolders.length; i++) {
        await fileManegerProvider.createFolder(
          location: android,
          folderName: androidFolders[i],
        );
      }
    }

    if (iosFolders != null) {
      for (var i = 0; i < iosFolders.length; i++) {
        await fileManegerProvider.createFolder(
          location: ios,
          folderName: iosFolders[i],
        );
      }
    }
  }
}
