import 'package:flutter/material.dart';

class BuildDeviceCard extends StatelessWidget {
  final TemplateLayoutType config;
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
    return SizedBox(
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
              width: 280,
              height: 530,
              margin: const EdgeInsets.only(top: 10),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Image(
                image: AssetImage('assets/images/test.png'),
              ),
            ),
          ),
          Positioned(
            left: config.devicePositionLeft,
            right: config.devicePositionRight,
            top: config.devicePositionTop,
            bottom: config.devicePositionBottom,
            child: const SizedBox(
              width: 280,
              height: 550,
              child: Image(
                image: AssetImage('assets/images/iphone.png'),
                color: null,
              ),
            ),
          ),
        ],
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

enum TemplateLayoutType {
  defaultLayout,
  titleUp,
  titleDown,
  rightSideTitleUp,
  leftSideTitleUp,
  rightSideTitleDown,
  leftSideTitleDown,
}

class TemplateLayoutConfig {
  final TemplateLayoutType type;
  final Axis? bodyDirection;
  final VerticalDirection? bodyVerticalDirection;
  final WrapCrossAlignment? bodyCrossAxisAlignment;
  final bool? showLogo, showTitle, showSubtitle;
  final MainAxisAlignment? logoAlignment, titleAlignment, subtitleAlignment;
  final String? title, subtitle;
  final double? devicePositionTop,
      devicePositionLeft,
      devicePositionRight,
      devicePositionBottom,
      bodyRunSpacing,
      bodySpacing,
      rotate,
      titlePaddingTop,
      titlePaddingBottom,
      titlePaddingLeft,
      titlePaddingRight,
      subtitlePaddingTop,
      subtitlePaddingBottom,
      subtitlePaddingLeft,
      subtitlePaddingRight,
      logoPaddingTop,
      logoPaddingBottom,
      logoPaddingLeft,
      logoPaddingRight;

  TemplateLayoutConfig({
    required this.type,
    this.logoAlignment,
    this.titleAlignment,
    this.subtitleAlignment,
    this.devicePositionTop,
    this.devicePositionLeft,
    this.devicePositionRight,
    this.devicePositionBottom,
    this.bodyDirection,
    this.bodyVerticalDirection,
    this.bodyCrossAxisAlignment,
    this.bodyRunSpacing,
    this.bodySpacing,
    this.rotate,
    this.titlePaddingTop,
    this.titlePaddingBottom,
    this.titlePaddingLeft,
    this.titlePaddingRight,
    this.subtitlePaddingTop,
    this.subtitlePaddingBottom,
    this.subtitlePaddingLeft,
    this.subtitlePaddingRight,
    this.logoPaddingTop,
    this.logoPaddingBottom,
    this.logoPaddingLeft,
    this.logoPaddingRight,
    this.showLogo,
    this.showTitle,
    this.showSubtitle,
    this.title,
    this.subtitle,
  });

  // return title up config
  TemplateLayoutConfig titleUp() {
    return TemplateLayoutConfig(
      type: TemplateLayoutType.titleUp,
      bodyDirection: Axis.horizontal,
      bodyVerticalDirection: VerticalDirection.down,
      bodyCrossAxisAlignment: WrapCrossAlignment.center,
      logoAlignment: MainAxisAlignment.center,
      titleAlignment: MainAxisAlignment.center,
      subtitleAlignment: MainAxisAlignment.center,
      devicePositionTop: null,
      devicePositionLeft: null,
      devicePositionRight: null,
      devicePositionBottom: null,
      bodyRunSpacing: 20,
      bodySpacing: 20,
      rotate: 0,
      titlePaddingTop: 30,
      titlePaddingBottom: 0,
      titlePaddingLeft: 0,
      titlePaddingRight: 0,
      subtitlePaddingTop: 0,
      subtitlePaddingBottom: 0,
      subtitlePaddingLeft: 0,
      subtitlePaddingRight: 0,
      logoPaddingTop: 20,
      logoPaddingBottom: 20,
      logoPaddingLeft: 20,
      logoPaddingRight: 20,
      showLogo: false,
      showTitle: true,
      showSubtitle: true,
      title: 'Your Title',
      subtitle: 'your Subtitle',
    );
  }

  // return title up config
  TemplateLayoutConfig titleDown() {
    return TemplateLayoutConfig(
      type: TemplateLayoutType.titleUp,
      bodyDirection: Axis.horizontal,
      bodyVerticalDirection: VerticalDirection.up,
      bodyCrossAxisAlignment: WrapCrossAlignment.center,
      logoAlignment: MainAxisAlignment.center,
      titleAlignment: MainAxisAlignment.center,
      subtitleAlignment: MainAxisAlignment.center,
      devicePositionTop: null,
      devicePositionLeft: null,
      devicePositionRight: null,
      devicePositionBottom: null,
      bodyRunSpacing: 20,
      bodySpacing: 20,
      rotate: 0,
      titlePaddingTop: 0,
      titlePaddingBottom: 0,
      titlePaddingLeft: 0,
      titlePaddingRight: 0,
      subtitlePaddingTop: 0,
      subtitlePaddingBottom: 30,
      subtitlePaddingLeft: 0,
      subtitlePaddingRight: 0,
      logoPaddingTop: 20,
      logoPaddingBottom: 20,
      logoPaddingLeft: 20,
      logoPaddingRight: 20,
      showLogo: false,
      showTitle: true,
      showSubtitle: true,
      title: 'Your Title',
      subtitle: 'your Subtitle',
    );
  }

  // swich case returns
  TemplateLayoutConfig getLayoutConfig() {
    switch (type) {
      case TemplateLayoutType.titleUp:
        return titleUp();
      case TemplateLayoutType.titleDown:
        return titleDown();
      case TemplateLayoutType.rightSideTitleUp:
        return titleUp();
      case TemplateLayoutType.leftSideTitleUp:
        return titleUp();
      case TemplateLayoutType.rightSideTitleDown:
        return titleUp();
      case TemplateLayoutType.leftSideTitleDown:
        return titleUp();
      default:
        return titleUp();
    }
  }
}
