import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/Micro/select_image_option_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildSelectImageOption extends StatelessWidget {
  final String? controllerTag, mockupId, title;
  final bool? askForRepeat;

  final void Function(String)? callback;
  final void Function(String, {bool? repeatForAll})? callbackForRepeat;
  const BuildSelectImageOption({
    super.key,
    this.controllerTag,
    this.mockupId,
    this.title,
    this.callback,
    this.askForRepeat,
    this.callbackForRepeat,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectImageOptionController>(
      init: SelectImageOptionController(),
      tag: controllerTag,
      initState: (_) {},
      builder: (_) {
        return ElevatedButton(
          onPressed: () => {
            // if askForRepeat is true, then we need to ask the user if they want to repeat the image
            if (askForRepeat == true)
              {
                Get.defaultDialog(
                  titlePadding: EdgeInsets.all(6.sp),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 6.sp,
                  ),
                  title: 'Repeat background?',
                  content: const Text(
                    'Do you want to repeat the background for all the mockups?',
                  ),
                  confirmTextColor: Get.theme.colorScheme.onPrimaryContainer,
                  cancelTextColor: Get.theme.colorScheme.onPrimaryContainer,
                  backgroundColor: Get.theme.colorScheme.primaryContainer,
                  confirm: Container(
                    margin: EdgeInsets.only(bottom: 6.sp),
                    child: InkWell(
                      onTap: () => {
                        Get.back(),
                        _.getImage(
                          mockupId: mockupId,
                          callbackForRepeat: callbackForRepeat,
                          shouldRepeat: true,
                        )
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Get.theme.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(4.sp),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.sp,
                          vertical: 2.sp,
                        ),
                        child: const Text('Yes Please!'),
                      ),
                    ),
                  ),
                  cancel: InkWell(
                    onTap: () => {
                      Get.back(),
                      _.getImage(
                        mockupId: mockupId,
                        callback: callback,
                      )
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.secondary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4.sp),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.sp,
                        vertical: 2.sp,
                      ),
                      child: const Text('No Thanks!'),
                    ),
                  ),
                ),
              }
            else
              {
                _.getImage(
                  mockupId: mockupId,
                  callback: callback,
                )
              }
          },
          child: Text(title ?? 'add image'),
        );
      },
    );
  }
}
