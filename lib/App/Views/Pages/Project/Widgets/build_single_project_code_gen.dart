import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_code_gen_controller.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:get/get.dart';
import 'package:graphite/graphite.dart';
import 'package:sizer/sizer.dart';

class BuildSingleProjectCodeGen
    extends GetView<ProjectSingleCodeGenController> {
  final String? localPath;
  const BuildSingleProjectCodeGen({
    super.key,
    this.localPath,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleCodeGenController>(
      init: ProjectSingleCodeGenController(),
      initState: (_) {},
      builder: (_) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/code_gen_bg.png'),
              repeat: ImageRepeat.repeat,
              opacity: 0.05,
            ),
          ),
          child: BuildLoadingOrEmptyLayout(
            isLoading: controller.isLoading,
            isEmpty: controller.models.isEmpty,
            hasButton: true,
            buttonText: 'create your first model',
            onButtonPressed: () => print('create model'),
            child: InteractiveViewer(
              constrained: false,
              child: Row(
                children: [
                  DirectGraph(
                    list: controller.nodes,
                    defaultCellSize: const Size(250.0, 300.0),
                    cellPadding: const EdgeInsets.all(40),
                    orientation: MatrixOrientation.Vertical,
                    nodeBuilder: (context, node) => const BuildCodeGenNode(),
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
        );

        // return BuildCustomDigram(controller: controller);
      },
    );
  }
}

class BuildCodeGenNode extends StatelessWidget {
  final Color? borderColor;
  const BuildCodeGenNode({
    super.key,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 300,
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: borderColor ?? Get.theme.colorScheme.secondaryContainer,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 5,
            margin: const EdgeInsets.only(
              top: 5,
              right: 5,
              left: 5,
            ),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 2.sp,
              right: 2.sp,
              bottom: 2.sp,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.drag_indicator,
                  color: Get.theme.colorScheme.onBackground.withOpacity(0.3),
                ),
                const Text('UserModel'),
                const Spacer(),
                IconButton.filled(
                  onPressed: () => print('edit'),
                  icon: const Icon(Icons.edit),
                  iconSize: 5.sp,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    backgroundColor: MaterialStateProperty.all(
                      Get.theme.colorScheme.secondaryContainer,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(height: 0, thickness: 0.5),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Get.theme.colorScheme.secondaryContainer
                        .withOpacity(0.3),
                    child: ListView.separated(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => const Divider(
                        height: 0,
                        thickness: 0.2,
                      ),
                      itemBuilder: (_, int index) {
                        return ListTile(
                          title: Text(
                            'name',
                            style: TextStyle(fontSize: 4.sp),
                          ),
                          trailing: const Badge(label: Text('String')),
                          visualDensity: VisualDensity.compact,
                          dense: true,
                          contentPadding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 0,
                            bottom: 0,
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(height: 0, thickness: 0.5),
                  ListView.separated(
                    itemCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => const Divider(
                      height: 0,
                      thickness: 0.2,
                    ),
                    itemBuilder: (_, int index) {
                      return ListTile(
                        title: Text(
                          'Profile',
                          style: TextStyle(fontSize: 4.sp),
                        ),
                        trailing: const Badge(
                          label: Text('has one'),
                          backgroundColor: Colors.greenAccent,
                          textColor: Colors.green,
                        ),
                        visualDensity: VisualDensity.compact,
                        dense: true,
                        contentPadding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 0,
                          bottom: 0,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
