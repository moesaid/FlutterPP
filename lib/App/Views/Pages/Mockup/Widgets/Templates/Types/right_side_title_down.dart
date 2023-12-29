import 'package:flutter/material.dart';
import 'package:flutterpp/App/Enums/template_layout_enum.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/template_layout_config.dart';

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
    devicePositionLeft: 155,
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
