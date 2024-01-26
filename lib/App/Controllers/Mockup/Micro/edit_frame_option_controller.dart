import 'package:device_frame/device_frame.dart';
import 'package:get/get.dart';

class EditFrameOptionController extends GetxController {
  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _selectedDevice = Devices.ios.iPhone13ProMax.obs;
  DeviceInfo get selectedDevice => _selectedDevice.value;

  final List<DeviceInfo> allIOS = Devices.ios.all;
  final List<DeviceInfo> allAndroid = Devices.android.all;

  final _iosHoveredIndex = 0.obs;
  int get iosHoveredIndex => _iosHoveredIndex.value;

  final _androidHoveredIndex = 0.obs;
  int get androidHoveredIndex => _androidHoveredIndex.value;

  setupController({String? fram}) async {
    if (fram != null) {
      DeviceInfo? local = Devices.all.firstWhereOrNull((el) => el.name == fram);
      if (local != null) {
        _selectedDevice.value = local;
      }
    }

    _isLoading.value = false;
    update();
  }

  onIosHoveredIndex(int index) => _iosHoveredIndex.value = index;
  onAndroidHoveredIndex(int index) => _androidHoveredIndex.value = index;

  onDeviceSelected(DeviceInfo deviceInfo) {
    _selectedDevice.value = deviceInfo;
  }

  onConfirm({
    Function(DeviceInfo)? callback,
  }) {
    callback?.call(_selectedDevice.value);
    Get.back();
  }
}
