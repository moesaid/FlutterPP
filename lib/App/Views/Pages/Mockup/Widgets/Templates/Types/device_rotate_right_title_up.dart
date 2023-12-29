import 'package:flutter/material.dart';
import 'package:flutterpp/App/Enums/template_layout_enum.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/template_layout_config.dart';

// return title up config
TemplateLayoutConfig deviceRotateRightTitleUp() {
  return TemplateLayoutConfig(
    type: TemplateLayoutEnum.deviceRotateRightTitleUp,
    bodyDirection: Axis.horizontal,
    bodyVerticalDirection: VerticalDirection.down,
    bodyCrossAxisAlignment: WrapCrossAlignment.center,
    logoAlignment: MainAxisAlignment.start,
    titleAlignment: MainAxisAlignment.start,
    subtitleAlignment: MainAxisAlignment.start,
    devicePositionTop: -130,
    devicePositionRight: -150,
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
    subtitlePaddingBottom: 0,
    subtitlePaddingLeft: 20,
    subtitlePaddingRight: 20,
    logoPaddingTop: 20,
    logoPaddingBottom: 20,
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
