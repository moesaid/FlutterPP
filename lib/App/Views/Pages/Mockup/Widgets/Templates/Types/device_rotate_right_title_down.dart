import 'package:flutter/material.dart';
import 'package:flutterpp/App/Enums/template_layout_enum.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/template_layout_config.dart';

// return title up config
TemplateLayoutConfig deviceRotateRightTitleDown() {
  return TemplateLayoutConfig(
    type: TemplateLayoutEnum.deviceRotateRightTitleDown,
    bodyDirection: Axis.horizontal,
    bodyVerticalDirection: VerticalDirection.up,
    bodyCrossAxisAlignment: WrapCrossAlignment.center,
    logoAlignment: MainAxisAlignment.end,
    titleAlignment: MainAxisAlignment.end,
    subtitleAlignment: MainAxisAlignment.end,
    devicePositionTop: 158,
    devicePositionRight: 110,
    devicePositionLeft: null,
    devicePositionBottom: null,
    bodyRunSpacing: 0,
    bodySpacing: 0,
    rotate: 0.104,
    titlePaddingTop: 30,
    titlePaddingBottom: 0,
    titlePaddingLeft: 20,
    titlePaddingRight: 20,
    subtitlePaddingTop: 0,
    subtitlePaddingBottom: 20,
    subtitlePaddingLeft: 20,
    subtitlePaddingRight: 20,
    logoPaddingTop: 0,
    logoPaddingBottom: 0,
    logoPaddingLeft: 20,
    logoPaddingRight: 20,
    showLogo: false,
    showTitle: true,
    deviceFullSize: true,
    showSubtitle: true,
    title: 'Your Title',
    subtitle: 'your Subtitle',
  );
}
