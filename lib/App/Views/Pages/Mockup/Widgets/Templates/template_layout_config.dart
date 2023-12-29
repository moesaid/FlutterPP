import 'package:flutter/material.dart';
import 'package:flutterpp/App/Enums/template_layout_enum.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/device_advance_rotate_right_title_down.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/device_advance_rotate_right_title_up.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/device_rotate_right_title_down.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/device_rotate_right_title_up.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/left_side_title_down.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/left_side_title_up.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/right_side_title_down.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/right_side_title_up.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/title_down.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/title_up.dart';

class TemplateLayoutConfig {
  final TemplateLayoutEnum type;
  final Axis? bodyDirection;
  final VerticalDirection? bodyVerticalDirection;
  final WrapCrossAlignment? bodyCrossAxisAlignment;
  final bool? showLogo, showTitle, showSubtitle, deviceFullSize;
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
    this.deviceFullSize = false,
    this.title,
    this.subtitle,
  });

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
      case TemplateLayoutEnum.deviceRotateRightTitleUp:
        return deviceRotateRightTitleUp();
      case TemplateLayoutEnum.deviceRotateRightTitleDown:
        return deviceRotateRightTitleDown();
      case TemplateLayoutEnum.deviceAdvanceRotateRightTitleUp:
        return deviceAdvanceRotateRightTitleUp();
      case TemplateLayoutEnum.deviceAdvanceRotateRightTitleDown:
        return deviceAdvanceRotateRightTitleDown();
      default:
        return titleUp();
    }
  }
}
