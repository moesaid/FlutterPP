import 'dart:math';

import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/template_config_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildDeviceCard extends StatelessWidget {
  final TemplateConfigModel config;
  final bool isSeleted;

  const BuildDeviceCard({
    super.key,
    required this.config,
    required this.isSeleted,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 300,
      height: 700,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        border: Border.all(
          strokeAlign: BorderSide.strokeAlignCenter,
          color:
              isSeleted ? Get.theme.colorScheme.secondary : Colors.transparent,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          const BuildDeviceHead(),
          Expanded(
            child: BuildDeviceBody(config: config),
          ),
        ],
      ),
    );
  }
}

class BuildDeviceBody extends StatelessWidget {
  final TemplateConfigModel config;

  const BuildDeviceBody({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 650,
      decoration: BoxDecoration(
        color: config.backgroundColor ?? Colors.white,
        image: config.backgroundImage != null
            ? DecorationImage(
                image: NetworkImage(config.backgroundImage!),
                fit: BoxFit.cover,
              )
            : null,
        gradient: config.backgroundGradient == null
            ? null
            : LinearGradient(
                colors: config.backgroundGradient!,
                transform: config.gradientAngle == null
                    ? null
                    : GradientRotation(config.gradientAngle! / 180 * 3.14),
              ),
      ),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          direction: config.bodyDirection!,
          verticalDirection: config.bodyVerticalDirection!,
          crossAxisAlignment: config.bodyCrossAxisAlignment!,
          runSpacing: config.bodyRunSpacing!,
          spacing: config.bodySpacing!,
          children: [
            BuildDeviceBodyHead(
              config: config,
            ),
            Transform.rotate(
              angle: (config.rotate ?? 0) * pi,
              child: BuildDeviceBodyIphoneCase(config: config),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildDeviceBodyIphoneCase extends StatelessWidget {
  final TemplateConfigModel config;
  const BuildDeviceBodyIphoneCase({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(
        config.firstDevicePositionRightLeft ?? 0,
        config.firstDevicePositionTopBottom ?? 0,
        0.0,
      ),
      child: SizedBox(
        width: 250,
        height: 500,
        child: DeviceFrame(
          device: Devices.ios.iPhone12ProMax,
          isFrameVisible: true,
          orientation: Orientation.portrait,
          screen: Image(
            fit: BoxFit.cover,
            image: config.image == null
                ? const AssetImage('assets/screenshots/screen_1.jpg')
                : NetworkImage(config.image!) as ImageProvider,
          ),
        ),
      ),
    );
  }
}

class BuildDeviceBodyHead extends StatelessWidget {
  final TemplateConfigModel config;
  const BuildDeviceBodyHead({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: config.logoAlignment!,
          children: [
            if (config.showLogo!)
              Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(
                  top: config.logoPaddingTop!,
                  bottom: config.logoPaddingBottom!,
                  left: config.logoPaddingLeft!,
                  right: config.logoPaddingRight!,
                ),
                child: config.logo != null
                    ? Image.network(config.logo!)
                    : const Placeholder(),
              ),
          ],
        ),
        if (config.showTitle!)
          Padding(
            padding: EdgeInsets.only(
              top: config.titlePaddingTop!,
              bottom: config.titlePaddingBottom!,
              left: config.titlePaddingLeft!,
              right: config.titlePaddingRight!,
            ),
            child: Row(
              mainAxisAlignment: config.titleAlignment!,
              children: [
                Text(
                  config.title!,
                  style: GoogleFonts.getFont(
                    config.titleFontFamily ?? 'Roboto',
                    fontSize: config.titleFontSize ?? 18,
                    color: config.titleColor ?? Colors.black,
                    height: config.titleLineHeight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        if (config.showSubtitle!)
          Padding(
            padding: EdgeInsets.only(
              top: config.subtitlePaddingTop!,
              bottom: config.subtitlePaddingBottom!,
              left: config.subtitlePaddingLeft!,
              right: config.subtitlePaddingRight!,
            ),
            child: Row(
              mainAxisAlignment: config.subtitleAlignment!,
              children: [
                Text(
                  config.subtitle!,
                  style: GoogleFonts.getFont(
                    config.subtitleFontFamily ?? 'Roboto',
                    fontSize: config.subtitleFontSize ?? 16,
                    color: config.subtitleColor ?? Colors.black,
                    height: config.subtitleLineHeight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class BuildDeviceHead extends StatelessWidget {
  const BuildDeviceHead({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      color: Colors.grey.withOpacity(0.25),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'iPhone 12 Pro Max',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
