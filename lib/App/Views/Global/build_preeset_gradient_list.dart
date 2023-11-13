import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Global/build_preset_gradient_list_controller.dart';
import 'package:flutterpp/App/Models/gradient_model.dart';
import 'package:flutterpp/App/Views/Global/build_appbar.dart';
import 'package:flutterpp/App/Views/Global/build_close_button.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/mockup_index_page.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:flutterpp/Helpers/text_helper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildPresetGradientList
    extends GetView<BuildPresetGradientListController> {
  final Function(GradientModel) onGradientSelected;

  final int? crossAxisCount;
  final double? crossAxisSpacing, mainAxisSpacing;

  const BuildPresetGradientList({
    required this.onGradientSelected,
    this.crossAxisCount,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuildPresetGradientListController>(
      init: BuildPresetGradientListController(),
      builder: (context) {
        List<GradientModel> list = controller.gradientsList;

        return Scaffold(
          backgroundColor:
              Get.theme.colorScheme.primaryContainer.withOpacity(0.95),
          appBar: const BuildAppBar(title: 'Gradients'),
          body: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BuildLoadingOrEmptyLayout(
                    isLoading: controller.isLoading,
                    isEmpty: controller.gradientsList.isEmpty,
                    child: GridView.builder(
                      itemCount: list.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount ?? 8,
                        crossAxisSpacing: crossAxisSpacing ?? 10,
                        mainAxisSpacing: mainAxisSpacing ?? 10,
                      ),
                      itemBuilder: (context, index) {
                        GradientModel item = list[index];
                        return InkWell(
                          onTap: () {
                            onGradientSelected.call(item);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Get.theme.colorScheme.onPrimary
                                    .withOpacity(0.1),
                              ),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: const Alignment(-1.0, 0.0),
                                        end: const Alignment(1.0, 0.0),
                                        transform: const GradientRotation(0),
                                        colors: item.colors != null &&
                                                item.colors!.isNotEmpty
                                            ? item.colors!
                                                .map((e) =>
                                                    ColorHelper.hexToColor(e))
                                                .toList()
                                            : [Colors.red, Colors.blue],
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Text(
                                    item.name?.limitLength(10) ?? 'No Name',
                                    style: Get.textTheme.bodyMedium
                                        ?.copyWith(fontSize: 5.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: BuildCloseButton(
                  bgColor: Get.theme.colorScheme.secondary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
