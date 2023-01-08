import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterpp/Config/app_gradients.dart';

class BuildProjectAvatar extends StatelessWidget {
  const BuildProjectAvatar({
    Key? key,
    required this.colors,
    required this.icon,
    this.width = 50,
    this.height = 50,
    this.svgWidth = 22,
    this.svgHeight = 22,
  }) : super(key: key);

  final List<Color> colors;
  final String icon;
  final double? width, height, svgWidth, svgHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        gradient: AppGradients.getGradient(colors: colors),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: SvgPicture.asset(
              'assets/svg/$icon',
              width: svgWidth,
              height: svgHeight,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
