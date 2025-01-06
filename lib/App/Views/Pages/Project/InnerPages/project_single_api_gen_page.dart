import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_api_gen_controller.dart';
import 'package:flutterpp/App/Views/Global/build_custom_dropdown.dart';
import 'package:flutterpp/App/Views/Global/build_empty_page.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/ApiGen/build_api_gen_node.dart';
import 'package:flutterpp/Config/app_print.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProjectSingleApiGenPage extends GetView<ProjectSingleApiGenController> {
  const ProjectSingleApiGenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleApiGenController>(
      init: ProjectSingleApiGenController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/code_gen_bg.png'),
                  repeat: ImageRepeat.repeat,
                  opacity: 0.07,
                ),
              ),
              child: Row(
                children: [
                  const ProjectSingleApiGenPageSidebar(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 5.spa),
                        // node
                        const BuildApiGenNode(),
                        const BuildApiGenNode(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProjectSingleApiGenPageSidebar extends StatelessWidget {
  const ProjectSingleApiGenPageSidebar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        border: Border(
          right: BorderSide(
            color: Get.theme.colorScheme.secondaryContainer,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(3.spa),
            padding: EdgeInsets.symmetric(
              vertical: 3.5.spa,
              horizontal: 3.spa,
            ),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(2.spa),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'workflows'.capitalize!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: ' / 5',
                        style: TextStyle(
                          color: Get.theme.colorScheme.onPrimary
                              .withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => AppPrint.print('add workflow'),
                  child: Icon(Icons.add, size: 6.spa),
                ),
              ],
            ),
          ),
          const Divider(height: 0, thickness: 0.5),
          Expanded(
            child: ListView.separated(
              itemCount: 50,
              padding: EdgeInsets.all(3.spa),
              separatorBuilder: (context, index) {
                return const Divider(thickness: 0.1);
              },
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => AppPrint.print('open workflow'),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 1.5.spa,
                      horizontal: 3.spa,
                    ),
                    decoration: BoxDecoration(
                      color: Get.theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(2.spa),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.api, size: 5.spa),
                        SizedBox(width: 2.spa),
                        Text('data'.capitalize!),
                        const Spacer(),
                        BuildCustomDropdown(
                          items: [
                            PopupMenuItem(
                              onTap: () => AppPrint.print('data'),
                              height: 10,
                              child: const Text('edit'),
                            ),
                          ],
                          child: Icon(
                            Icons.more_horiz,
                            size: 8.spa,
                            color: Get.theme.colorScheme.onPrimary
                                .withValues(alpha: 0.5),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectSingleApiGenEmptyState extends StatelessWidget {
  const ProjectSingleApiGenEmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BuildEmptyPage(
        title: 'no api classes found for this project'.capitalize!,
        hasButton: true,
        buttonTitle: 'create a Workflow'.capitalize!,
        onTap: () => AppPrint.print('add api class'),
      ),
    );
  }
}
