import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Auth/splash_controller.dart';
import 'package:flutterpp/App/Views/Global/build_logo.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BuildLogo(size: 30.sp),
                  ],
                ),
              ),
              if (controller.version.isNotEmpty)
                Positioned(
                  bottom: 10.sp,
                  child: Column(
                    children: [
                      SizedBox(
                        width: context.width * 0.015,
                        height: context.width * 0.015,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(height: 5.sp),
                      Text(controller.version),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
