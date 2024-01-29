import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Dashboard/dashboard_controller.dart';
import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_project_avatar.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

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
