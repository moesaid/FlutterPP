import 'package:awesome_side_sheet/Enums/sheet_position.dart';
import 'package:awesome_side_sheet/side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/dashboard_controller.dart';
import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Views/Global/build_loading_switch.dart';
import 'package:flutterpp/App/Views/Pages/Project/Pages/project_create_page.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_project_avatar.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: BuildLoadingSwitch(
              isLoading: controller.isLoading,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(5.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hey ${controller.profile.fullName} 🖐️'.capitalize!,
                      style: TextStyle(
                        fontSize: 6.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 1.sp),
                    Text(
                      'welcome to the mysterious realm of limitless potential, where blank pages eagerly await your unique imprint. 🚀',
                      style: TextStyle(
                        fontSize: 5.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    SizedBox(
                      height: 60.sp,
                      child: GridView(
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 5.sp,
                          mainAxisSpacing: 5.sp,
                          mainAxisExtent: 60.sp,
                        ),
                        children: [
                          BuildDashboardNumbersItem(controller: controller),
                          BuildDashboardNumbersItem(controller: controller),
                          BuildDashboardNumbersItem(controller: controller),
                          BuildDashboardNumbersItem(controller: controller),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    BuildDashboardProjectSection(controller: controller),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BuildDashboardNumbersItem extends StatelessWidget {
  const BuildDashboardNumbersItem({
    super.key,
    required this.controller,
  });

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.sp),
        color: Get.theme.colorScheme.primaryContainer,
        border: Border.all(
          width: 1,
          color: Get.theme.colorScheme.secondaryContainer,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'team members'.capitalize!,
                        style: TextStyle(
                          fontSize: 4.sp,
                          fontWeight: FontWeight.w400,
                          color: Get.theme.colorScheme.onBackground.withOpacity(
                            0.3,
                          ),
                        ),
                      ),
                      Text(
                        controller.teamMembers.length.toString(),
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(1.sp),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.indigo,
                    ),
                    child: Icon(
                      Icons.supervised_user_circle_rounded,
                      size: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(thickness: 0.5, height: 0),
          Padding(
            padding: EdgeInsets.all(1.sp),
            child: TextButton(
              onPressed: () => print('object'),
              child: Text(
                'view all'.capitalize!,
                style: TextStyle(
                  fontSize: 3.6.sp,
                  color: Get.theme.colorScheme.onBackground,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildDashboardProjectSection extends StatelessWidget {
  const BuildDashboardProjectSection({
    super.key,
    required this.controller,
  });

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('projects'.capitalize!),
        SizedBox(height: 3.sp),
        Row(
          children: [
            BuildDashboardCreateProject(controller: controller),
            SizedBox(width: 5.sp),
            Expanded(
              child: SizedBox(
                height: 180,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.projects.length,
                  separatorBuilder: (context, index) => SizedBox(
                    width: 5.sp,
                  ),
                  itemBuilder: (context, index) {
                    ProjectModel item = controller.projects[index];
                    return BuildDashboardProjectItem(
                      controller: controller,
                      item: item,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BuildDashboardProjectItem extends StatelessWidget {
  const BuildDashboardProjectItem({
    super.key,
    required this.controller,
    required this.item,
  });

  final DashboardController controller;
  final ProjectModel item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 180,
          height: 180,
          padding: EdgeInsets.all(5.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.sp),
            border: Border.all(
              width: 1,
              color: item.id == controller.activeProject.id
                  ? Get.theme.colorScheme.secondary
                  : Get.theme.colorScheme.primaryContainer,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BuildProjectAvatar(
                colors: [
                  ColorHelper.hexToColor(item.color1!),
                  ColorHelper.hexToColor(item.color2!)
                ],
                icon: item.icon!,
              ),
              SizedBox(height: 2.sp),
              Text(
                item.title?.capitalize ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 5.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 1.sp),
              Text(
                item.description ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 3.6.sp,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            final RenderBox button = context.findRenderObject() as RenderBox;
            final RenderBox overlay =
                Overlay.of(context).context.findRenderObject() as RenderBox;

            showMenu(
              context: context,
              position: RelativeRect.fromRect(
                Rect.fromPoints(
                  button.localToGlobal(Offset.zero, ancestor: overlay),
                  button.localToGlobal(
                    button.size.bottomLeft(Offset.zero),
                    ancestor: overlay,
                  ),
                ),
                Offset.zero & overlay.size,
              ),
              items: [
                PopupMenuItem(
                  onTap: () => controller.updateActiveProject(item),
                  child: Text(
                    'set active'.capitalize!,
                  ),
                ),
              ],
            );
          },
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }
}

class BuildDashboardCreateProject extends StatelessWidget {
  const BuildDashboardCreateProject({
    super.key,
    required this.controller,
  });
  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        aweSideSheet(
          context: context,
          sheetPosition: SheetPosition.right,
          footer: const SizedBox.shrink(),
          title: 'Create new project'.capitalize!,
          sheetWidth: context.width * 0.8,
          body: Obx(() {
            debugPrint(controller.selectedColors.first.toString());
            return ProjectCreatePage(
              createProject: (data) => controller.createProject(formData: data),
              onColorChange: (data) => controller.onColorChange(data),
              onSvgChange: (data) => controller.onSVGChange(data),
              activeColors: controller.selectedColors,
              activeSVG: controller.selectedSVG,
              colors: controller.colors,
              svgs: controller.svgs,
            );
          }),
        );
      },
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.sp),
          color: Get.theme.colorScheme.background,
          border: Border.all(
            width: 1,
            color: Get.theme.colorScheme.primaryContainer,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.add_rounded, size: 50),
            SizedBox(height: 1.sp),
            Text(
              'create new project'.capitalize!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 4.sp),
            ),
          ],
        ),
      ),
    );
  }
}
