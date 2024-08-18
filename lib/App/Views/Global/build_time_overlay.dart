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
          width: 200.spa,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(4.spa),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 200.spa,
                height: 80.spa,
                child: Image.asset(
                  'assets/images/time.gif',
                  fit: BoxFit.cover,
                ),
              ),
              Material(
                child: Padding(
                  padding: EdgeInsets.all(8.0.spa),
                  child: Column(
                    children: [
                      Text(
                        'Hold tight!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 6.spa,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2.spa),
                      Text(
                        r'''This might take longer than a snail's coffee break, so feel free to practice your air guitar solos while we work our magic behind the scenes. 🐌🎸''',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 5.spa,
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
              SizedBox(height: 10.spa),
            ],
          ),
        ),
      ],
    );
  }
}
