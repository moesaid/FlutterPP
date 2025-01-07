import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutterpp/App/Controllers/Mockup/Micro/select_image_option_controller.dart';
import 'package:get/get.dart';

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
      builder: (localController) {
        return ElevatedButton(
          onPressed: () async {
            // if askForRepeat is true, then we need to ask the user if they want to repeat the image
            if (askForRepeat == true) {
              await FlutterPlatformAlert.playAlertSound();

              final CustomButton result =
                  await FlutterPlatformAlert.showCustomAlert(
                windowTitle: 'Background repeat',
                text:
                    'Do you want to repeat the background for all the mockups?',
                positiveButtonTitle: "yes please!",
                neutralButtonTitle: "no thanks!",
              );

              if (result == CustomButton.neutralButton) {
                localController.getImage(
                  mockupId: mockupId,
                  callback: callbackForRepeat,
                );
              } else {
                localController.getImage(
                  mockupId: mockupId,
                  callbackForRepeat: callbackForRepeat,
                  shouldRepeat: true,
                );
              }
            } else {
              localController.getImage(
                mockupId: mockupId,
                callback: callback,
              );
            }
          },
          child: Text(title ?? 'add image'),
        );
      },
    );
  }
}
