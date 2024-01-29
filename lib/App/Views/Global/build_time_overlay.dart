import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class BuildTimeOverlay extends StatelessWidget {
  const BuildTimeOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 200.sp,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.background,
            borderRadius: BorderRadius.circular(4.sp),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 200.sp,
                height: 80.sp,
                child: Image.asset(
                  'assets/images/time.gif',
                  fit: BoxFit.cover,
                ),
              ),
              Material(
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Column(
                    children: [
                      Text(
                        'Hold tight!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 6.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2.sp),
                      Text(
                        r'''This might take longer than a snail's coffee break, so feel free to practice your air guitar solos while we work our magic behind the scenes. 🐌🎸''',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 5.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              LoadingAnimationWidget.staggeredDotsWave(
                color: Get.theme.colorScheme.secondary,
                size: 30,
              ),
              SizedBox(height: 10.sp),
            ],
          ),
        ),
      ],
    );
  }
}
