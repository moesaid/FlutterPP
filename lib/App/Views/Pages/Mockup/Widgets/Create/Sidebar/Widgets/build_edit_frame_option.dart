import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/Micro/edit_frame_option_controller.dart';
import 'package:flutterpp/App/Views/Global/build_loading_switch.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildEditFrame extends StatelessWidget {
  final String? controllerTag;
  final void Function(DeviceInfo)? callback;

  const BuildEditFrame({
    super.key,
    this.controllerTag,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditFrameOptionController>(
      init: EditFrameOptionController(),
      tag: controllerTag,
      initState: (_) {},
      builder: (_) {
        return ElevatedButton(
          onPressed: () {
            aweSideSheet(
              context: context,
              sheetWidth: context.width,
              sheetPosition: SheetPosition.right,
              header: const SizedBox.shrink(),
              onCancel: () => Get.back(),
              onConfirm: () => _.onConfirm(callback: callback),
              body: _BuildBody(controller: _, callback: callback),
            );
          },
          child: Text('edit Frame'.capitalize!),
        );
      },
    );
  }
}

class _BuildBody extends StatelessWidget {
  final EditFrameOptionController controller;
  final void Function(DeviceInfo)? callback;
  const _BuildBody({
    required this.controller,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return BuildLoadingSwitch(
      isLoading: controller.isLoading,
      child: Container(
        width: context.width,
        padding: EdgeInsets.only(
          top: 12.sp,
          left: 8.sp,
          right: 8.sp,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'change frame'.capitalize!,
                style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'change the frame of your mockup'.capitalize!,
                style: TextStyle(
                  fontSize: 5.sp,
                  fontStyle: FontStyle.italic,
                  color: Get.theme.colorScheme.onBackground.withOpacity(0.5),
                ),
              ),
              Divider(height: 10.sp, thickness: 0.4),
              SizedBox(
                width: context.width,
                height: 35.h,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(5.sp),
                  itemCount: Devices.ios.all.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(
                    width: 5.sp,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    DeviceInfo device = Devices.ios.all[index];
                    return InkWell(
                      onTap: () => controller.onDeviceSelected(
                        deviceInfo: device,
                      ),
                      child: MouseRegion(
                        onEnter: (_) => controller.onIosHoveredIndex(index),
                        onExit: (_) => controller.onIosHoveredIndex(
                          Devices.ios.all.length + 1,
                        ),
                        child: Obx(
                          () => AnimatedScale(
                            duration: const Duration(milliseconds: 100),
                            scale: controller.iosHoveredIndex == index
                                ? 1.03
                                : 1.0,
                            child: Column(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    child: DeviceFrame(
                                      device: device,
                                      isFrameVisible: true,
                                      screen: Container(),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 1.sp),
                                Text(
                                  device.name,
                                  style: TextStyle(
                                    fontSize: 5.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(height: 20.sp),
              SizedBox(
                width: context.width,
                height: 35.h,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(5.sp),
                  itemCount: Devices.android.all.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(
                    width: 5.sp,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    DeviceInfo device = Devices.android.all[index];
                    return InkWell(
                      onTap: () => controller.onDeviceSelected(
                        deviceInfo: device,
                      ),
                      child: MouseRegion(
                        onEnter: (_) => controller.onAndroidHoveredIndex(index),
                        onExit: (_) => controller.onAndroidHoveredIndex(
                          Devices.android.all.length + 1,
                        ),
                        child: Obx(
                          () => AnimatedScale(
                            duration: const Duration(milliseconds: 100),
                            scale: controller.androidHoveredIndex == index
                                ? 1.03
                                : 1.0,
                            child: Column(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    child: DeviceFrame(
                                      device: device,
                                      isFrameVisible: true,
                                      screen: Container(),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 1.sp),
                                Text(
                                  device.name,
                                  style: TextStyle(
                                    fontSize: 5.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10.sp),
            ],
          ),
        ),
      ),
    );
  }
}
