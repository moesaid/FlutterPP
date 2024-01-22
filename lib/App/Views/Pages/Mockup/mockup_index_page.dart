import 'dart:math';

import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/mockup_index_controller.dart';
import 'package:flutterpp/App/Models/mockup_model.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:flutterpp/App/Views/Global/build_page_layout.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/mockup_create_page.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_project_avatar.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MockupIndexPage extends GetView<MockupIndexController> {
  const MockupIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MockupIndexController>(
      init: MockupIndexController(),
      initState: (_) {},
      builder: (_) {
        return BuildPageLayout(
          child: BuildLoadingOrEmptyLayout(
            isLoading: controller.isLoading,
            isEmpty: controller.items.isEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'mockups'.capitalizeFirst!,
                      style: Get.theme.textTheme.titleLarge,
                    ),
                    IconButton(
                      onPressed: () => aweSideSheet(
                        context: context,
                        sheetPosition: SheetPosition.right,
                        body: const MockupCreatePage(),
                        sheetWidth: 50.h,
                        title: 'Create a new mockup',
                        footer: const SizedBox(),
                      ),
                      icon: const Icon(Icons.add),
                      color: Get.theme.colorScheme.secondary,
                    ),
                  ],
                ),
                Divider(
                  height: 20.sp,
                  thickness: 0.5,
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: controller.items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 5.sp,
                      mainAxisSpacing: 5.sp,
                      mainAxisExtent: 60.sp,
                    ),
                    itemBuilder: (context, index) => BuildMockupIndexItem(
                        controller: controller, item: controller.items[index]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BuildMockupIndexItem extends StatelessWidget {
  const BuildMockupIndexItem({
    super.key,
    required this.controller,
    required this.item,
  });

  final MockupIndexController controller;
  final MockupModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.MOCKUP_SINGLE, arguments: item),
      onHover: (value) => controller.onHover(value, item.id!),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.sp),
          border: Border.all(
            color: controller.hoveredId == item.id
                ? ColorHelper.hexToColor(item.color1!).withOpacity(0.5)
                : Get.theme.colorScheme.secondaryContainer,
            width: 1,
          ),
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1,
            colors: [
              ColorHelper.hexToColor(item.color1 ?? '#000000')
                  .withOpacity(controller.hoveredId == item.id ? 0.2 : 0.1),
              Get.theme.colorScheme.primaryContainer
                  .withOpacity(controller.hoveredId == item.id ? 0.2 : 0.1),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BuildProjectAvatar(
                  colors: [
                    ColorHelper.hexToColor(
                      item.color1 ?? '#000000',
                    ),
                    ColorHelper.hexToColor(
                      item.color2 ?? '#000000',
                    ),
                  ],
                  icon: item.icon!,
                ),
                Badge(
                  label: Text(
                    item.category!.capitalize!,
                    style:
                        Get.textTheme.labelSmall?.copyWith(letterSpacing: 0.3),
                  ),
                  backgroundColor: Get.theme.colorScheme.secondaryContainer,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title!.capitalize!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Get.theme.textTheme.titleMedium,
                ),
                Text(
                  item.description!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Get.theme.textTheme.bodySmall,
                ),
              ],
            )
          ],
        ),
      ),
    );
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 30.h,
            child: Image.asset(
              'assets/images/Clay_Black0041.png',
              fit: BoxFit.contain,
            ),
          ),
          Text(
            list![Random().nextInt(list!.length)],
            style: Get.theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // side sheet
              aweSideSheet(
                context: context,
                sheetPosition: SheetPosition.right,
                body: const MockupCreatePage(),
                sheetWidth: 50.h,
                title: 'Create a new mockup',
                footer: const SizedBox(),
              );
            },
            child: const Text('Create a new mockup'),
          ),
        ],
      ),
    );
  }
}
