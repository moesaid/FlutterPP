import 'dart:math';

import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/template_config_model.dart';
import 'package:flutterpp/App/Views/Global/build_custom_dropdown.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildDeviceCard extends StatelessWidget {
  final TemplateConfigModel config;
  final void Function(TemplateConfigModel) onRemove,
      copyItemToAll,
      pasteItem,
      copyItem;

  final bool isSeleted;

  const BuildDeviceCard({
    super.key,
    required this.config,
    required this.isSeleted,
    required this.onRemove,
    required this.copyItemToAll,
    required this.pasteItem,
    required this.copyItem,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 350,
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
          BuildDeviceHead(
            config: config,
            onRemove: onRemove,
            copyItemToAll: copyItemToAll,
            copyItem: copyItem,
            pasteItem: pasteItem,
          ),
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
      width: 350,
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
            BuildDeviceBodyHead(config: config),
            BuildDeviceBodyIphoneCase(config: config),
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
    return Stack(
      children: [
        (config.showDevice != true)
            ? const SizedBox.shrink()
            : Transform.rotate(
                angle: (config.rotate ?? 0) * pi,
                child: ScaleTransition(
                  scale: config.scale == null
                      ? const AlwaysStoppedAnimation(1)
                      : AlwaysStoppedAnimation(config.scale!),
                  child: Transform(
                    transform: Matrix4.translationValues(
                      config.firstDevicePositionRightLeft ?? 0,
                      config.firstDevicePositionTopBottom ?? 0,
                      0.0,
                    ),
                    child: SizedBox(
                      width: 250,
                      height: 500,
                      child: Container(
                        decoration: BoxDecoration(
                          border: config.showStroke == true
                              ? Border.all(
                                  color: config.strokeColor ?? Colors.black,
                                  width: config.strokeWidth ?? 10,
                                )
                              : null,
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            if (config.showShadow == true)
                              BoxShadow(
                                color: config.shadowColor ?? Colors.transparent,
                                blurRadius: config.shadowBlur ?? 0,
                                offset: Offset(
                                  config.shadowOffsetX ?? 0,
                                  config.shadowOffsetY ?? 0,
                                ),
                              ),
                          ],
                        ),
                        child: DeviceFrame(
                          device: config.firstDeviceFrame == null
                              ? Devices.ios.iPhone12ProMax
                              : Devices.all.firstWhereOrNull(
                                    (el) => el.name == config.firstDeviceFrame!,
                                  ) ??
                                  Devices.ios.iPhone12ProMax,
                          isFrameVisible: config.showFrame ?? true,
                          orientation: Orientation.portrait,
                          screen: Image(
                            fit: BoxFit.cover,
                            image: config.image == null
                                ? const AssetImage(
                                    'assets/screenshots/screen_1.jpg')
                                : NetworkImage(config.image!) as ImageProvider,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        (config.showSecondDevice != true)
            ? const SizedBox.shrink()
            : Transform.rotate(
                angle: (config.secondRotate ?? 0) * pi,
                child: ScaleTransition(
                  scale: config.secondScale == null
                      ? const AlwaysStoppedAnimation(1)
                      : AlwaysStoppedAnimation(config.secondScale!),
                  child: Transform(
                    transform: Matrix4.translationValues(
                      config.secondDevicePositionRightLeft ?? 0,
                      config.secondDevicePositionTopBottom ?? 0,
                      0.0,
                    ),
                    child: SizedBox(
                      width: 250,
                      height: 500,
                      child: Container(
                        decoration: BoxDecoration(
                          border: config.showSecondStroke == true
                              ? Border.all(
                                  color:
                                      config.secondStrokeColor ?? Colors.black,
                                  width: config.secondStrokeWidth ?? 10,
                                )
                              : null,
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            if (config.showSecondShadow == true)
                              BoxShadow(
                                color: config.secondShadowColor ??
                                    Colors.transparent,
                                blurRadius: config.secondShadowBlur ?? 0,
                                offset: Offset(
                                  config.secondShadowOffsetX ?? 0,
                                  config.secondShadowOffsetY ?? 0,
                                ),
                              ),
                          ],
                        ),
                        child: DeviceFrame(
                          device: config.secondDeviceFrame == null
                              ? Devices.ios.iPhone12ProMax
                              : Devices.all.firstWhereOrNull(
                                    (el) =>
                                        el.name == config.secondDeviceFrame!,
                                  ) ??
                                  Devices.ios.iPhone12ProMax,
                          isFrameVisible: config.showSecondFrame ?? true,
                          orientation: Orientation.portrait,
                          screen: Image(
                            fit: BoxFit.cover,
                            image: config.secondImage == null
                                ? const AssetImage(
                                    'assets/screenshots/screen_1.jpg')
                                : NetworkImage(config.secondImage!)
                                    as ImageProvider,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ],
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
                Flexible(
                  child: Text(
                    config.title!,
                    style: GoogleFonts.getFont(
                      config.titleFontFamily ?? 'Roboto',
                      fontSize: config.titleFontSize ?? 18,
                      color: config.titleColor ?? Colors.black,
                      height: config.titleLineHeight,
                      fontWeight: FontWeight.bold,
                    ),
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
                Flexible(
                  child: Text(
                    config.subtitle!,
                    style: GoogleFonts.getFont(
                      config.subtitleFontFamily ?? 'Roboto',
                      fontSize: config.subtitleFontSize ?? 16,
                      color: config.subtitleColor ?? Colors.black,
                      height: config.subtitleLineHeight,
                      fontWeight: FontWeight.bold,
                    ),
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
  final TemplateConfigModel config;
  final void Function(TemplateConfigModel)? onRemove,
      pasteItem,
      copyItem,
      copyItemToAll;

  const BuildDeviceHead({
    super.key,
    required this.config,
    this.onRemove,
    this.copyItemToAll,
    this.pasteItem,
    this.copyItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
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
          BuildCustomDropdown(
            items: [
              PopupMenuItem<String>(
                onTap: () => onRemove?.call(config),
                child: ListTile(
                  leading: const Icon(Icons.delete),
                  title: Text('remove'.capitalize!),
                  mouseCursor: SystemMouseCursors.click,
                ),
              ),
              PopupMenuItem<String>(
                onTap: () => copyItemToAll?.call(config),
                child: ListTile(
                  leading: const Icon(Icons.copy),
                  title: Text('copy style to all'.capitalize!),
                  mouseCursor: SystemMouseCursors.click,
                ),
              ),
              PopupMenuItem<String>(
                onTap: () => pasteItem?.call(config),
                child: ListTile(
                  leading: const Icon(Icons.paste),
                  title: Text('paste style'.capitalize!),
                  mouseCursor: SystemMouseCursors.click,
                ),
              ),
              PopupMenuItem<String>(
                onTap: () => copyItem?.call(config),
                child: ListTile(
                  leading: const Icon(Icons.copy),
                  title: Text('copy style'.capitalize!),
                  mouseCursor: SystemMouseCursors.click,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
