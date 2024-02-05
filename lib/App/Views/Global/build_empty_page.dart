import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class BuildEmptyPage extends StatelessWidget {
  final List<String>? list;
  final bool? hasButton;
  final VoidCallback? onTap;
  final String? buttonTitle, title;
  const BuildEmptyPage({
    super.key,
    this.list = const [
      "Welcome to the mysterious realm of limitless potential, where blank pages eagerly await your unique imprint. 🚀",
      "Step into the void and unleash your imagination upon this empty canvas, for within lies a universe of untold wonders. ✨",
      "Behold, an empty page—an open invitation to weave your thoughts and dreams into a tapestry of endless possibilities. 🎨",
      "Greetings, adventurer! This blank slate is your playground, so go forth and sculpt a world that defies all conventions. 🌟",
      "In this pixelated abyss, the absence of content is merely an opportunity for your ingenuity to manifest in unexpected ways. 🌌",
      "Enter the realm of boundless creation, where the absence of words whispers an enchanting tale of infinite potential. 📚",
      "Within this vacant space, your creativity dances freely, painting strokes of brilliance on the canvas of imagination. 🎭",
      "Brace yourself, for in this void lies a realm where the absence of structure births the most extraordinary ideas. 💡",
      "Embrace the emptiness, for it is the breeding ground of innovation, where the seeds of imagination sprout and flourish. 🌱",
      "Welcome to the blank chapter of your journey, where you hold the pen to write a story that defies all expectations. 📝",
    ],
    this.hasButton,
    this.onTap,
    this.buttonTitle,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 22.h,
            height: 22.h,
            child: Lottie.asset('assets/lottie/empty_box.json'),
          ),
          SizedBox(
            width: context.width * 0.5,
            child: Text(
              title ?? list![Random().nextInt(list!.length)],
              textAlign: TextAlign.center,
              style: Get.theme.textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 20),
          if (hasButton == true)
            ElevatedButton(
              onPressed: onTap,
              child: Text(buttonTitle ?? 'Create'),
            ),
        ],
      ),
    );
  }
}
