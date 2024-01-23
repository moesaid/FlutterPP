import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/mockup_single_controller.dart';
import 'package:flutterpp/App/Models/template_config_model.dart';
import 'package:flutterpp/App/Views/Global/build_appbar.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/build_create_mockup_sidebar.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_device_card.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MockupSinglePage extends GetView<MockupSingleController> {
  const MockupSinglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MockupSingleController>(
      init: MockupSingleController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: BuildAppBar(
            title: 'Mockup',
            hasBackButton: true,
            onBack: () => Get.back(),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: Colors.black26,
                    padding: EdgeInsets.all(10.sp),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 700,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: controller.mockup.jsonData!.length,
                              padding: EdgeInsets.only(
                                right: 140.sp,
                                left: 2.sp,
                                top: 2.sp,
                                bottom: 2.sp,
                              ),
                              itemBuilder: (_, int i) {
                                TemplateConfigModel config =
                                    controller.mockup.jsonData![i];
                                return InkWell(
                                  onTap: () => controller.updateSelectedItem(
                                    config,
                                  ),
                                  child: BuildDeviceCard(
                                    config: config,
                                    isSeleted:
                                        controller.seletedItem.id == config.id,
                                  ),
                                );
                              },
                              separatorBuilder: (_, __) => SizedBox(
                                width: 3.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: BuildCreateMockupSidebar(
                    isScreenshotSelected: controller.seletedItem.id != null,

                    // start background
                    initialColor: controller.seletedItem.backgroundColor,
                    onColorChangedCallback: (Color color) =>
                        controller.updateBackground(color: color),
                    // end background
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: ElevatedButton(
                    onPressed: () => controller.updateMockup(),
                    child: const Text('save'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
