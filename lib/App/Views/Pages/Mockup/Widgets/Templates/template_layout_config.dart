import 'package:flutter/material.dart';
import 'package:flutterpp/App/Enums/template_layout_enum.dart';

class TemplateLayoutConfig {
  final TemplateLayoutEnum type;
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
      type: TemplateLayoutEnum.titleUp,
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
      type: TemplateLayoutEnum.titleDown,
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

  // return right side title up config
  TemplateLayoutConfig rightSideTitleUp() {
    return TemplateLayoutConfig(
      type: TemplateLayoutEnum.rightSideTitleUp,
      bodyDirection: Axis.horizontal,
      bodyVerticalDirection: VerticalDirection.down,
      bodyCrossAxisAlignment: WrapCrossAlignment.center,
      logoAlignment: MainAxisAlignment.center,
      titleAlignment: MainAxisAlignment.center,
      subtitleAlignment: MainAxisAlignment.center,
      devicePositionTop: null,
      devicePositionLeft: 130,
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

  // return left side title up config
  TemplateLayoutConfig leftSideTitleUp() {
    return TemplateLayoutConfig(
      type: TemplateLayoutEnum.leftSideTitleUp,
      bodyDirection: Axis.horizontal,
      bodyVerticalDirection: VerticalDirection.down,
      bodyCrossAxisAlignment: WrapCrossAlignment.center,
      logoAlignment: MainAxisAlignment.center,
      titleAlignment: MainAxisAlignment.center,
      subtitleAlignment: MainAxisAlignment.center,
      devicePositionTop: null,
      devicePositionLeft: null,
      devicePositionRight: 150,
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

  // return right side title up config
  TemplateLayoutConfig rightSideTitleDown() {
    return TemplateLayoutConfig(
      type: TemplateLayoutEnum.rightSideTitleUp,
      bodyDirection: Axis.horizontal,
      bodyVerticalDirection: VerticalDirection.up,
      bodyCrossAxisAlignment: WrapCrossAlignment.center,
      logoAlignment: MainAxisAlignment.center,
      titleAlignment: MainAxisAlignment.center,
      subtitleAlignment: MainAxisAlignment.center,
      devicePositionTop: null,
      devicePositionLeft: 130,
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
      case TemplateLayoutEnum.titleUp:
        return titleUp();
      case TemplateLayoutEnum.titleDown:
        return titleDown();
      case TemplateLayoutEnum.rightSideTitleUp:
        return rightSideTitleUp();
      case TemplateLayoutEnum.leftSideTitleUp:
        return leftSideTitleUp();
      case TemplateLayoutEnum.rightSideTitleDown:
        return rightSideTitleDown();
      case TemplateLayoutEnum.leftSideTitleDown:
        return leftSideTitleDown();
      default:
        return titleUp();
    }
  }
}

// return left side title up config
TemplateLayoutConfig leftSideTitleDown() {
  return TemplateLayoutConfig(
    type: TemplateLayoutEnum.leftSideTitleUp,
    bodyDirection: Axis.horizontal,
    bodyVerticalDirection: VerticalDirection.up,
    bodyCrossAxisAlignment: WrapCrossAlignment.center,
    logoAlignment: MainAxisAlignment.center,
    titleAlignment: MainAxisAlignment.center,
    subtitleAlignment: MainAxisAlignment.center,
    devicePositionTop: null,
    devicePositionLeft: null,
    devicePositionRight: 150,
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
