import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/Micro/alignment_option_controller.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_sidebar_option.dart';
import 'package:get/get.dart';

class BuildAlignmentOption extends GetView<AlignmentOptionController> {
  final IconData? firtIcon, secondIcon, thirdIcon;
  final String? title, controllerTag;
  final void Function(MainAxisAlignment)? onToggle;
  final MainAxisAlignment? initialAlignment;

  const BuildAlignmentOption({
    super.key,
    this.firtIcon,
    this.secondIcon,
    this.thirdIcon,
    this.title,
    this.controllerTag,
    this.onToggle,
    this.initialAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlignmentOptionController>(
      init: AlignmentOptionController(),
      tag: controllerTag,
      didChangeDependencies: (state) {
        state.controller?.setAlignment(alignment: initialAlignment!);
      },
      builder: (_) {
        return BuildSidebarOption(
          title: title ?? 'Alignment',
          rightWidget: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.background.withOpacity(0.3),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _.setAlignment(
                      alignment: MainAxisAlignment.start,
                      onToggle: onToggle,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                            _.alignment == MainAxisAlignment.start ? 0.1 : 0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(
                        firtIcon ?? Icons.align_horizontal_left_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => _.setAlignment(
                      alignment: MainAxisAlignment.center,
                      onToggle: onToggle,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                            _.alignment == MainAxisAlignment.center ? 0.1 : 0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(
                        secondIcon ?? Icons.align_horizontal_center_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => _.setAlignment(
                      alignment: MainAxisAlignment.end,
                      onToggle: onToggle,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                            _.alignment == MainAxisAlignment.end ? 0.1 : 0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(
                        thirdIcon ?? Icons.align_horizontal_right_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
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
