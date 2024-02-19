import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/mockup_index_controller.dart';
import 'package:flutterpp/App/Models/mockup_model.dart';
import 'package:flutterpp/App/Views/Global/build_custom_dropdown.dart';
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
            hasButton: true,
            buttonText: 'Create a new mockup',
            onButtonPressed: () => aweSideSheet(
              context: context,
              sheetWidth: context.width * 0.8,
              sheetPosition: SheetPosition.right,
              body: const MockupCreatePage(),
              title: 'Create a new mockup',
              footer: const SizedBox(),
            ),
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
                        sheetWidth: context.width * 0.8,
                        sheetPosition: SheetPosition.right,
                        body: const MockupCreatePage(),
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
              children: [
                BuildProjectAvatar(
                  colors: [
                    ColorHelper.hexToColor(item.color1 ?? '#000000'),
                    ColorHelper.hexToColor(item.color2 ?? '#000000'),
                  ],
                  icon: item.icon!,
                ),
                const Spacer(),
                Badge(
                  label: Text(
                    item.category!.capitalize!,
                    style:
                        Get.textTheme.labelSmall?.copyWith(letterSpacing: 0.3),
                  ),
                  backgroundColor: Get.theme.colorScheme.secondaryContainer,
                ),
                BuildCustomDropdown(
                  items: [
                    PopupMenuItem<String>(
                      onTap: () => controller.deleteItem(item.id!),
                      child: const ListTile(
                        title: Text('delete'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title!.capitalize!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Get.theme.textTheme.titleMedium?.copyWith(
                    fontSize: 6.sp,
                  ),
                ),
                Text(
                  item.description!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Get.theme.textTheme.bodySmall?.copyWith(
                    fontSize: 4.sp,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
