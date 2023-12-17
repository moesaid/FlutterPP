import 'package:flutter/material.dart';
import 'package:flutterpp/App/Enums/template_layout_enum.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/template_layout_config.dart';

class BuildDeviceCard extends StatelessWidget {
  final TemplateLayoutEnum config;
  const BuildDeviceCard({Key? key, required this.config}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 700,
      child: Column(
        children: [
          const BuildDeviceHead(),
          BuildDeviceBody(
            config: TemplateLayoutConfig(type: config).getLayoutConfig(),
          ),
        ],
      ),
    );
  }
}

class BuildDeviceBody extends StatelessWidget {
  final TemplateLayoutConfig config;
  const BuildDeviceBody({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 650,
      child: Card(
        elevation: 0,
        color: Colors.white,
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
  final TemplateLayoutConfig config;
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
        height: 550,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: config.devicePositionLeft,
              right: config.devicePositionRight,
              top: config.devicePositionTop,
              bottom: config.devicePositionBottom,
              child: Container(
                height: 530,
                margin: const EdgeInsets.only(top: 10),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Image(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/screenshots/index.jpeg'),
                ),
              ),
            ),
            Positioned(
              left: config.devicePositionLeft,
              right: config.devicePositionRight,
              top: config.devicePositionTop,
              bottom: config.devicePositionBottom,
              child: const SizedBox(
                height: 550,
                child: Image(
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
  final TemplateLayoutConfig config;
  const BuildDeviceBodyHead({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (config.showLogo!)
              Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(
                  top: config.logoPaddingTop!,
                  bottom: config.logoPaddingBottom!,
                  left: config.logoPaddingLeft!,
                  right: config.logoPaddingRight!,
                ),
                child: const Placeholder(),
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
