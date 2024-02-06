import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_code_gen_controller.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_code_gen_floating_button.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_code_gen_node.dart';
import 'package:get/get.dart';
import 'package:graphite/graphite.dart';

class ProjectSingleCodeGen extends GetView<ProjectSingleCodeGenController> {
  final String? localPath;

  const ProjectSingleCodeGen({
    super.key,
    this.localPath,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleCodeGenController>(
      init: ProjectSingleCodeGenController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          floatingActionButton: BuildCodeGenFloatingButton(
            controller: controller,
            sharedContext: context,
            sheetWidth: context.width * 0.4,
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/code_gen_bg.png'),
                repeat: ImageRepeat.repeat,
                opacity: 0.07,
              ),
            ),
            child: BuildLoadingOrEmptyLayout(
              isLoading: controller.isLoading,
              isEmpty: controller.models.isEmpty,
              hasButton: true,
              buttonText: 'create your first model'.capitalize!,
              onButtonPressed: () => controller.fetchApi(),
              // onButtonPressed: () => openCreateOrEditModel(context: context),
              child: InteractiveViewer(
                constrained: false,
                child: Row(
                  children: [
                    DirectGraph(
                      list: controller.nodes,
                      defaultCellSize: const Size(250.0, 300),
                      cellPadding: const EdgeInsets.all(40),
                      orientation: MatrixOrientation.Vertical,
                      nodeBuilder: (context, node) => BuildCodeGenNode(
                        uuid: node.id,
                        items: controller.models,
                      ),
                      paintBuilder: (edge) {
                        var p = Paint()
                          ..color = Get.theme.colorScheme.primary
                          ..style = PaintingStyle.stroke
                          ..strokeCap = StrokeCap.round
                          ..strokeJoin = StrokeJoin.round
                          ..strokeWidth = 2;

                        return p;
                      },
                    ),
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
