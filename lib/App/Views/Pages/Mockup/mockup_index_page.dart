import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/mockup_index_controller.dart';
import 'package:flutterpp/App/Providers/Local/app_mode.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:flutterpp/App/Views/Global/build_page_layout.dart';
import 'package:get/get.dart';

class MockupIndexPage extends GetView<MockupIndexController> {
  const MockupIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MockupIndexController>(
      init: MockupIndexController(),
      initState: (_) {},
      builder: (_) {
        return const BuildPageLayout(
          child: BuildLoadingOrEmptyLayout(
            isLoading: false,
            isEmpty: true,
            child: Text('asd'),
          ),
        );
      },
    );
  }
}

class BuildLoadingOrEmptyLayout extends StatelessWidget {
  final bool isLoading, isEmpty;
  final Widget child;

  const BuildLoadingOrEmptyLayout({
    super.key,
    required this.isLoading,
    required this.isEmpty,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: BuildOverlay())
        : isEmpty
            ? const BuildEmptyPage()
            : child;
  }
}

class BuildEmptyPage extends StatelessWidget {
  final List<String>? list;
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
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: Image.asset(
              'assets/images/Clay_Black0041.png',
              fit: BoxFit.contain,
            ),
          ),
          // Text(
          //   list![Random().nextInt(list!.length)],
          //   style: Get.theme.textTheme.titleMedium,
          // ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              AppMode().change(context);
            },
            child: const Text('mode'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // side sheet
              aweSideSheet(
                context: context,
                sheetPosition: SheetPosition.right,
              );
            },
            child: const Text('Create a new mockup'),
          ),
        ],
      ),
    );
  }
}
