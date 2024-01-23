import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/template_config_model.dart';
import 'package:get/get.dart';

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
          Expanded(child: BuildDeviceBody(config: config)),
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
            BuildDeviceBodyHead(config: config),
            Transform.rotate(
              angle: config.rotate!,
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
    return Transform.rotate(
      angle: config.rotate!,
      child: SizedBox(
        width: 300,
        height: config.deviceFullSize == false ? 700 : 530,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Positioned(
              left: (config.devicePositionLeft != null)
                  ? config.devicePositionLeft! + 20
                  : null,
              right: (config.devicePositionRight != null)
                  ? config.devicePositionRight! + 20
                  : null,
              top: config.devicePositionTop,
              bottom: config.devicePositionBottom,
              child: Container(
                height: config.deviceFullSize == false ? 670 : 500,
                margin: const EdgeInsets.only(top: 10),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(
                      config.deviceFullSize == false ? 20 : 15),
                ),
                child: const Image(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/screenshots/screen_1.jpg'),
                ),
              ),
            ),
            Positioned(
              left: config.devicePositionLeft,
              right: config.devicePositionRight,
              top: config.devicePositionTop,
              bottom: config.devicePositionBottom,
              child: SizedBox(
                height: config.deviceFullSize == false ? 700 : 530,
                child: const Image(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/iphone.png'),
                  color: null,
                ),
              ),
            ),
          ],
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
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
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
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
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
