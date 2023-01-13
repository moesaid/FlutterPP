import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/project_single_board_controller.dart';
import 'package:flutterpp/App/Views/Global/build_loading_page.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_board_widges.dart';
import 'package:get/get.dart';

class ProjectSingleBoardPage extends GetView<ProjectSingleBoardController> {
  const ProjectSingleBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // config
    AppFlowyBoardConfig config = AppFlowyBoardConfig(
      groupBackgroundColor: Get.theme.colorScheme.primaryContainer,
      cornerRadius: 10,
    );

    return GetBuilder<ProjectSingleBoardController>(
      init: ProjectSingleBoardController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: controller.isLoading
                ? const BuildLoadingPage()
                : controller.boards.isEmpty
                    ? const _BuildEmptyState()
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: AppFlowyBoard(
                          controller: controller.boardController,
                          cardBuilder: (context, group, groupItem) {
                            return AppFlowyGroupCard(
                              decoration: BoxDecoration(
                                color: Get.theme.colorScheme.secondaryContainer,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              key: ValueKey(groupItem.id),
                              child: _buildCard(groupItem),
                            );
                          },
                          headerBuilder: (context, columnData) {
                            return BuildAppFlowyHeader(
                              appFlowyController: controller.boardController,
                              columnData: columnData,
                            );
                          },
                          footerBuilder: (context, columnData) {
                            return BuildAppFlowyFooter(
                              columnData: columnData,
                            );
                          },
                          groupConstraints: const BoxConstraints.tightFor(
                            width: 250,
                          ),
                          config: config,
                        ),
                      ),
          ),
        );
      },
    );
  }
}

class _BuildEmptyState extends StatelessWidget {
  const _BuildEmptyState({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Empty Board');
  }
}

Widget _buildCard(AppFlowyGroupItem item) {
  if (item is TextItem) {
    return RichTextCard(item: item.s);
  }

  if (item is RichTextItem) {
    return RichTextCard(item: item.title);
  }

  throw UnimplementedError();
}
