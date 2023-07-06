import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_sidebar_option.dart';
import 'package:get/get.dart';

class BuildAlignmentOption extends StatelessWidget {
  final IconData? firtIcon, secondIcon, thirdIcon;
  final String? title;
  final VoidCallback? onFirstIconTap, onSecondIconTap, onThirdIconTap;
  final bool? isFirtIconSelected, isSecondIconSelected, isThirdIconSelected;

  const BuildAlignmentOption({
    super.key,
    this.firtIcon,
    this.secondIcon,
    this.thirdIcon,
    this.title,
    this.onFirstIconTap,
    this.onSecondIconTap,
    this.onThirdIconTap,
    this.isFirtIconSelected = true,
    this.isSecondIconSelected = false,
    this.isThirdIconSelected = false,
  });

  @override
  Widget build(BuildContext context) {
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
                onTap: onFirstIconTap,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color:
                        Colors.white.withOpacity(isFirtIconSelected! ? 0.1 : 0),
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
                onTap: onSecondIconTap,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white
                        .withOpacity(isSecondIconSelected! ? 0.1 : 0),
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
                onTap: onThirdIconTap,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white
                        .withOpacity(isThirdIconSelected! ? 0.1 : 0),
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
  }
}
