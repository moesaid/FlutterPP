import 'package:device_frame/device_frame.dart';
import 'package:get/get.dart';

class EditFrameOptionController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _selectedDevice = Devices.ios.iPhone13ProMax.obs;
  DeviceInfo get selectedDevice => _selectedDevice.value;

  final _iosHoveredIndex = 0.obs;
  int get iosHoveredIndex => _iosHoveredIndex.value;

  final _androidHoveredIndex = 0.obs;
  int get androidHoveredIndex => _androidHoveredIndex.value;

  onIosHoveredIndex(int index) => _iosHoveredIndex.value = index;
  onAndroidHoveredIndex(int index) => _androidHoveredIndex.value = index;

  onDeviceSelected({
    required DeviceInfo deviceInfo,
  }) {
    _selectedDevice.value = deviceInfo;
  }

  onConfirm({
    Function(DeviceInfo)? callback,
  }) {
    callback?.call(_selectedDevice.value);
    Get.back();
  }
}
