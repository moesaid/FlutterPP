import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterpp/App/Controllers/Global/build_icon_and_gradients_controllers.dart';
import 'package:flutterpp/App/Views/Global/build_close_button.dart';
import 'package:flutterpp/App/Views/Global/build_loading_page.dart';
import 'package:flutterpp/Config/app_gradients.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildIconAndGradients extends StatelessWidget {
  final Function(List<Color>) onColorChange;
  final Function(String) onSvgChange;
  final double? height;

  const BuildIconAndGradients({
    Key? key,
    required this.onColorChange,
    required this.onSvgChange,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuildIconAndGradientsController>(
      init: BuildIconAndGradientsController(),
      initState: (_) {},
      builder: (_) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: height ?? 50.w,
              decoration: BoxDecoration(
                color: Get.theme.bottomSheetTheme.backgroundColor,
                border: Border(
                  top: BorderSide(
                    color: Get.theme.scaffoldBackgroundColor,
                    width: 1,
                  ),
                ),
              ),
              child: (_.colors.isEmpty || _.svgs.isEmpty)
                  ? const BuildLoadingPage()
                  : Row(
                      children: [
                        _BuildIconSection(
                          svgs: _.svgs,
                          onSvgChange: (val) {
                            _.onSVGChange(val);
                            onSvgChange.call(val);
                          },
                          colors: _.colors,
                        ),
                        const VerticalDivider(width: 0),
                        _BuildColorsSection(
                          colors: _.colors,
                          onColorChange: (val) {
                            _.onColorChange(val);
                            onColorChange.call(val);
                          },
                        ),
                      ],
                    ),
            ),
            Positioned(
              top: -20,
              right: 20,
              child: BuildCloseButton(
                bgColor: Get.theme.primaryColor,
                size: 20.sp,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _BuildColorsSection extends StatelessWidget {
  const _BuildColorsSection({
    Key? key,
    required this.colors,
    required this.onColorChange,
  }) : super(key: key);

  final List<List<Color>> colors;
  final Function(List<Color> p1) onColorChange;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${colors.length} Colors',
              style: Get.textTheme.titleLarge,
            ),
            const SizedBox(height: 5),
            const Text('Color us creative, yo.'),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: colors.length,
                shrinkWrap: true,
                itemBuilder: (_, int i) {
                  return InkWell(
                    onTap: () {
                      onColorChange.call(colors[i]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: AppGradients.getGradient(colors: colors[i]),
                      ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 2.sp,
                  mainAxisSpacing: 2.sp,
                  childAspectRatio: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildIconSection extends StatelessWidget {
  const _BuildIconSection({
    Key? key,
    required this.svgs,
    required this.onSvgChange,
    required this.colors,
  }) : super(key: key);

  final List<String> svgs;
  final Function(String p1) onSvgChange;
  final List<List<Color>> colors;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${svgs.length} Icons',
              style: Get.textTheme.titleLarge,
            ),
            SizedBox(height: 1.sp),
            const Text('Time to choose an icon, peeps!'),
            SizedBox(height: 10.sp),
            Expanded(
              child: GridView.builder(
                itemCount: svgs.length,
                shrinkWrap: true,
                itemBuilder: (_, int i) {
                  return InkWell(
                    onTap: () {
                      onSvgChange.call(svgs[i]);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(3.sp),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: SvgPicture.asset(
                            'assets/svg/${svgs[i]}',
                            // color: Colors.grey.withOpacity(0.5),
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcATop,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 2.sp,
                  mainAxisSpacing: 2.sp,
                  childAspectRatio: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
