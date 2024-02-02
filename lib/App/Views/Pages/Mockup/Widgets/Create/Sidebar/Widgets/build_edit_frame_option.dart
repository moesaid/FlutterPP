import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/Micro/edit_frame_option_controller.dart';
import 'package:flutterpp/App/Views/Global/build_loading_switch.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildEditFrame extends StatelessWidget {
  final String? controllerTag, initialValue;
  final void Function(DeviceInfo)? callback;

  const BuildEditFrame({
    super.key,
    this.controllerTag,
    this.callback,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditFrameOptionController>(
      init: EditFrameOptionController(),
      tag: controllerTag,
      didChangeDependencies: (state) {
        state.controller?.setupController(fram: initialValue);
      },
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
              Obx(
                () => _BuildDeviceList(
                  items: controller.allIOS,
                  onEnter: controller.onIosHoveredIndex,
                  onExit: controller.onIosHoveredIndex,
                  onTap: controller.onDeviceSelected,
                  activeHoveredIndex: controller.iosHoveredIndex,
                  selectedDevice: controller.selectedDevice,
                ),
              ),
              Divider(height: 20.sp),
              Obx(
                () => _BuildDeviceList(
                  items: controller.allAndroid,
                  onEnter: controller.onAndroidHoveredIndex,
                  onExit: controller.onAndroidHoveredIndex,
                  onTap: controller.onDeviceSelected,
                  activeHoveredIndex: controller.androidHoveredIndex,
                  selectedDevice: controller.selectedDevice,
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

class _BuildDeviceList extends StatelessWidget {
  final List<DeviceInfo> items;
  final void Function(int)? onEnter;
  final void Function(int)? onExit;
  final void Function(DeviceInfo)? onTap;
  final int? activeHoveredIndex;
  final DeviceInfo? selectedDevice;

  const _BuildDeviceList({
    required this.items,
    this.onEnter,
    this.onExit,
    this.onTap,
    this.activeHoveredIndex,
    this.selectedDevice,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: 35.h,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.all(5.sp),
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(
          width: 5.sp,
        ),
        itemBuilder: (BuildContext context, int index) {
          DeviceInfo device = items[index];
          return InkWell(
            onTap: () => onTap?.call(device),
            child: MouseRegion(
              onEnter: (_) => onEnter?.call(index),
              onExit: (_) => onExit?.call(items.length + 1),
              child: AnimatedScale(
                duration: const Duration(milliseconds: 200),
                scale: activeHoveredIndex == index ? 1.03 : 1.0,
                child: Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: DeviceFrame(
                          device: device,
                          isFrameVisible: true,
                          screen: Image.asset(
                            'assets/screenshots/screen_3.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 3.sp),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize: 5.sp,
                        fontWeight: FontWeight.w600,
                        color: selectedDevice?.name == device.name
                            ? Get.theme.colorScheme.secondary
                            : Get.theme.colorScheme.onPrimary.withOpacity(0.5),
                      ),
                      child: Row(
                        children: [
                          Text(device.name),
                          SizedBox(width: 2.sp),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity:
                                selectedDevice?.name == device.name ? 1.0 : 0.0,
                            child: Icon(
                              Icons.check_circle,
                              size: 6.sp,
                              color: Colors.green,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
