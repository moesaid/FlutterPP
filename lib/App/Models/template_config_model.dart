import 'package:flutter/material.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';

class TemplateConfigModel {
  String? id, image, secondImage, logo, firstDeviceFrame, secondDeviceFrame;
  String? type;
  Axis? bodyDirection;
  VerticalDirection? bodyVerticalDirection;
  WrapCrossAlignment? bodyCrossAxisAlignment;
  MainAxisAlignment? logoAlignment;
  MainAxisAlignment? titleAlignment;
  MainAxisAlignment? subtitleAlignment;
  double? firstDevicePositionTopBottom;
  double? firstDevicePositionRightLeft;
  double? secondDevicePositionTopBottom;
  double? secondDevicePositionRightLeft;
  double? bodyRunSpacing;
  double? bodySpacing;
  double? rotate, secondRotate;
  double? titlePaddingTop, subtitlePaddingTop;
  double? titlePaddingBottom, subtitlePaddingBottom;
  double? titlePaddingLeft, subtitlePaddingLeft;
  double? titlePaddingRight, subtitlePaddingRight;
  double? logoPaddingTop;
  double? logoPaddingBottom;
  double? logoPaddingLeft;
  double? logoPaddingRight;
  double? titleFontSize, titleLineHeight, subtitleFontSize, subtitleLineHeight;
  bool? showLogo, showSecondLogo, deviceFullSize, secondDeviceFullSize;
  bool? showTitle,
      showSubtitle,
      showDevice,
      showSecondDevice,
      showFrame,
      showSecondFrame,
      showStroke,
      showSecondStroke;
  String? title, subtitle;
  String? titleFontFamily, subtitleFontFamily;
  String? backgroundImage;
  Color? backgroundColor,
      titleColor,
      subtitleColor,
      strokeColor,
      secondStrokeColor,
      shadowColor,
      secondShadowColor;
  List<Color>? backgroundGradient;
  double? gradientAngle,
      strokeWidth,
      secondStrokeWidth,
      shadowBlur,
      secondShadowBlur,
      shadowOffsetX,
      shadowOffsetY,
      secondShadowOffsetX,
      secondShadowOffsetY;

  TemplateConfigModel({
    this.id,
    this.image,
    this.secondImage,
    this.logo,
    this.firstDeviceFrame,
    this.secondDeviceFrame,
    this.type,
    this.bodyDirection,
    this.bodyVerticalDirection,
    this.bodyCrossAxisAlignment,
    this.logoAlignment,
    this.titleAlignment,
    this.subtitleAlignment,
    this.firstDevicePositionTopBottom,
    this.firstDevicePositionRightLeft,
    this.secondDevicePositionTopBottom,
    this.secondDevicePositionRightLeft,
    this.bodyRunSpacing,
    this.bodySpacing,
    this.rotate,
    this.secondRotate,
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
    this.title,
    this.subtitle,
    this.backgroundImage,
    this.backgroundColor,
    this.backgroundGradient,
    this.titleColor,
    this.titleFontSize,
    this.titleLineHeight,
    this.subtitleFontSize,
    this.subtitleLineHeight,
    this.subtitleFontFamily,
    this.titleFontFamily,
    this.subtitleColor,
    this.strokeColor,
    this.secondStrokeColor,
    this.shadowColor,
    this.secondShadowColor,
    this.deviceFullSize = false,
    this.secondDeviceFullSize = false,
    this.showLogo = false,
    this.showSecondLogo = false,
    this.showTitle = false,
    this.showSubtitle = false,
    this.showDevice = true,
    this.showSecondDevice = false,
    this.showFrame = true,
    this.showSecondFrame = false,
    this.showStroke = false,
    this.showSecondStroke = false,
    this.gradientAngle = 0,
    this.strokeWidth = 0,
    this.secondStrokeWidth = 0,
    this.shadowBlur = 0,
    this.secondShadowBlur = 0,
    this.shadowOffsetX = 0,
    this.shadowOffsetY = 0,
    this.secondShadowOffsetX = 0,
    this.secondShadowOffsetY = 0,
  });

  TemplateConfigModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    secondImage = json['secondImage'];
    logo = json['logo'];
    type = json['type'];
    firstDeviceFrame = json['firstDeviceFrame'];
    secondDeviceFrame = json['secondDeviceFrame'];

    // bodyDirection = json['bodyDirection'];
    // convert bodyDirection string to Axis enum
    switch (json['bodyDirection']) {
      case 'horizontal':
        bodyDirection = Axis.horizontal;
        break;
      case 'vertical':
        bodyDirection = Axis.vertical;
        break;
      default:
        bodyDirection = Axis.horizontal;
    }

    // bodyVerticalDirection = json['bodyVerticalDirection'];
    // convert bodyVerticalDirection string to VerticalDirection enum
    switch (json['bodyVerticalDirection']) {
      case 'up':
        bodyVerticalDirection = VerticalDirection.up;
        break;
      case 'down':
        bodyVerticalDirection = VerticalDirection.down;
        break;
      default:
        bodyVerticalDirection = VerticalDirection.down;
    }

    // bodyCrossAxisAlignment = json['bodyCrossAxisAlignment'];
    // convert bodyCrossAxisAlignment string to WrapCrossAlignment enum
    switch (json['bodyCrossAxisAlignment']) {
      case 'start':
        bodyCrossAxisAlignment = WrapCrossAlignment.start;
        break;
      case 'end':
        bodyCrossAxisAlignment = WrapCrossAlignment.end;
        break;
      case 'center':
        bodyCrossAxisAlignment = WrapCrossAlignment.center;
        break;

      default:
        bodyCrossAxisAlignment = WrapCrossAlignment.center;
    }

    // logoAlignment = json['logoAlignment'];
    // convert logoAlignment string to MainAxisAlignment enum
    switch (json['logoAlignment']) {
      case 'start':
        logoAlignment = MainAxisAlignment.start;
        break;
      case 'end':
        logoAlignment = MainAxisAlignment.end;
        break;
      case 'center':
        logoAlignment = MainAxisAlignment.center;
        break;
      default:
        logoAlignment = MainAxisAlignment.center;
    }

    // titleAlignment = json['titleAlignment'];
    // convert titleAlignment string to MainAxisAlignment enum
    switch (json['titleAlignment']) {
      case 'start':
        titleAlignment = MainAxisAlignment.start;
        break;
      case 'end':
        titleAlignment = MainAxisAlignment.end;
        break;
      case 'center':
        titleAlignment = MainAxisAlignment.center;
        break;
      default:
        titleAlignment = MainAxisAlignment.center;
    }

    // subtitleAlignment = json['subtitleAlignment'];
    // convert subtitleAlignment string to MainAxisAlignment enum
    switch (json['subtitleAlignment']) {
      case 'start':
        subtitleAlignment = MainAxisAlignment.start;
        break;
      case 'end':
        subtitleAlignment = MainAxisAlignment.end;
        break;
      case 'center':
        subtitleAlignment = MainAxisAlignment.center;
        break;
      default:
        subtitleAlignment = MainAxisAlignment.center;
    }

    deviceFullSize = json['deviceFullSize'];
    secondDeviceFullSize = json['secondDeviceFullSize'];
    firstDevicePositionTopBottom =
        convertIntToDouble(json['firstDevicePositionTopBottom']);
    firstDevicePositionRightLeft = convertIntToDouble(
        json['firstDevicePositionRightLeft'] ?? json['devicePositionRight']);
    secondDevicePositionTopBottom = convertIntToDouble(
        json['secondDevicePositionTopBottom'] ?? json['devicePositionBottom']);
    secondDevicePositionRightLeft = convertIntToDouble(
        json['secondDevicePositionRightLeft'] ?? json['devicePositionLeft']);
    bodyRunSpacing = convertIntToDouble(json['bodyRunSpacing']);
    bodySpacing = convertIntToDouble(json['bodySpacing']);
    rotate = convertIntToDouble(json['rotate']);
    secondRotate = convertIntToDouble(json['secondRotate']);
    titlePaddingTop = convertIntToDouble(json['titlePaddingTop']);
    titlePaddingBottom = convertIntToDouble(json['titlePaddingBottom']);
    titlePaddingLeft = convertIntToDouble(json['titlePaddingLeft']);
    titlePaddingRight = convertIntToDouble(json['titlePaddingRight']);
    subtitlePaddingTop = convertIntToDouble(json['subtitlePaddingTop']);
    subtitlePaddingBottom = convertIntToDouble(json['subtitlePaddingBottom']);
    subtitlePaddingLeft = convertIntToDouble(json['subtitlePaddingLeft']);
    subtitlePaddingRight = convertIntToDouble(json['subtitlePaddingRight']);
    logoPaddingTop = convertIntToDouble(json['logoPaddingTop']);
    logoPaddingBottom = convertIntToDouble(json['logoPaddingBottom']);
    logoPaddingLeft = convertIntToDouble(json['logoPaddingLeft']);
    logoPaddingRight = convertIntToDouble(json['logoPaddingRight']);
    showLogo = json['showLogo'];
    showSecondLogo = json['showSecondLogo'];
    showTitle = json['showTitle'];
    showSubtitle = json['showSubtitle'];
    showDevice = json['showDevice'];
    showSecondDevice = json['showSecondDevice'];
    showFrame = json['showFrame'];
    showSecondFrame = json['showSecondFrame'];
    showStroke = json['showStroke'];
    showSecondStroke = json['showSecondStroke'];
    title = json['title'];
    subtitle = json['subtitle'];

    backgroundImage = json['backgroundImage'];
    backgroundColor = json['backgroundColor'] != null
        ? ColorHelper.hexToColor(json['backgroundColor'])
        : null;

    backgroundGradient = json['backgroundGradient'] != null
        ? [
            ColorHelper.hexToColor(json['backgroundGradient'][0]),
            ColorHelper.hexToColor(json['backgroundGradient'][1]),
          ]
        : null;

    gradientAngle = convertIntToDouble(json['gradientAngle']);
    strokeWidth = convertIntToDouble(json['strokeWidth']);
    secondStrokeWidth = convertIntToDouble(json['secondStrokeWidth']);

    strokeColor = json['strokeColor'] != null
        ? ColorHelper.hexToColor(json['strokeColor'])
        : null;

    secondStrokeColor = json['secondStrokeColor'] != null
        ? ColorHelper.hexToColor(json['secondStrokeColor'])
        : null;

    shadowColor = json['shadowColor'] != null
        ? ColorHelper.hexToColor(json['shadowColor'])
        : null;

    secondShadowColor = json['secondShadowColor'] != null
        ? ColorHelper.hexToColor(json['secondShadowColor'])
        : null;

    titleColor = json['titleColor'] != null
        ? ColorHelper.hexToColor(json['titleColor'])
        : null;
    subtitleColor = json['subtitleColor'] != null
        ? ColorHelper.hexToColor(json['subtitleColor'])
        : null;

    titleFontSize = convertIntToDouble(json['titleFontSize']);
    titleLineHeight = convertIntToDouble(json['titleLineHeight']);
    subtitleFontSize = convertIntToDouble(json['subtitleFontSize']);
    subtitleLineHeight = convertIntToDouble(json['subtitleLineHeight']);
    shadowBlur = convertIntToDouble(json['shadowBlur']);
    secondShadowBlur = convertIntToDouble(json['secondShadowBlur']);
    shadowOffsetX = convertIntToDouble(json['shadowOffsetX']);
    shadowOffsetY = convertIntToDouble(json['shadowOffsetY']);
    secondShadowOffsetX = convertIntToDouble(json['secondShadowOffsetX']);
    secondShadowOffsetY = convertIntToDouble(json['secondShadowOffsetY']);
    titleFontFamily = json['titleFontFamily'];
    subtitleFontFamily = json['subtitleFontFamily'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['secondImage'] = secondImage;
    data['logo'] = logo;
    data['type'] = type.toString();
    data['firstDeviceFrame'] = firstDeviceFrame;
    data['secondDeviceFrame'] = secondDeviceFrame;

    // data['bodyDirection'] = bodyDirection;
    // convert bodyDirection enum to string
    switch (bodyDirection) {
      case Axis.horizontal:
        data['bodyDirection'] = 'horizontal';
        break;
      case Axis.vertical:
        data['bodyDirection'] = 'vertical';
        break;
      default:
        data['bodyDirection'] = 'horizontal';
    }

    // data['bodyVerticalDirection'] = bodyVerticalDirection;
    // convert bodyVerticalDirection enum to string
    switch (bodyVerticalDirection) {
      case VerticalDirection.up:
        data['bodyVerticalDirection'] = 'up';
        break;
      case VerticalDirection.down:
        data['bodyVerticalDirection'] = 'down';
        break;
      default:
        data['bodyVerticalDirection'] = 'down';
    }

    // data['bodyCrossAxisAlignment'] = bodyCrossAxisAlignment;
    // convert bodyCrossAxisAlignment enum to string
    switch (bodyCrossAxisAlignment) {
      case WrapCrossAlignment.start:
        data['bodyCrossAxisAlignment'] = 'start';
        break;
      case WrapCrossAlignment.end:
        data['bodyCrossAxisAlignment'] = 'end';
        break;
      case WrapCrossAlignment.center:
        data['bodyCrossAxisAlignment'] = 'center';
        break;
      default:
        data['bodyCrossAxisAlignment'] = 'center';
    }

    // data['logoAlignment'] = logoAlignment;
    // convert logoAlignment enum to string
    switch (logoAlignment) {
      case MainAxisAlignment.start:
        data['logoAlignment'] = 'start';
        break;
      case MainAxisAlignment.end:
        data['logoAlignment'] = 'end';
        break;
      case MainAxisAlignment.center:
        data['logoAlignment'] = 'center';
        break;
      default:
        data['logoAlignment'] = 'center';
    }

    // data['titleAlignment'] = titleAlignment;
    // convert titleAlignment enum to string
    switch (titleAlignment) {
      case MainAxisAlignment.start:
        data['titleAlignment'] = 'start';
        break;
      case MainAxisAlignment.end:
        data['titleAlignment'] = 'end';
        break;
      case MainAxisAlignment.center:
        data['titleAlignment'] = 'center';
        break;
      default:
        data['titleAlignment'] = 'center';
    }

    // data['subtitleAlignment'] = subtitleAlignment;
    // convert subtitleAlignment enum to string
    switch (subtitleAlignment) {
      case MainAxisAlignment.start:
        data['subtitleAlignment'] = 'start';
        break;
      case MainAxisAlignment.end:
        data['subtitleAlignment'] = 'end';
        break;
      case MainAxisAlignment.center:
        data['subtitleAlignment'] = 'center';
        break;
      default:
        data['subtitleAlignment'] = 'center';
    }

    data['deviceFullSize'] = deviceFullSize;
    data['secondDeviceFullSize'] = secondDeviceFullSize;
    data['firstDevicePositionTopBottom'] =
        convertIntToDouble(firstDevicePositionTopBottom);
    data['firstDevicePositionRightLeft'] =
        convertIntToDouble(firstDevicePositionRightLeft);
    data['secondDevicePositionTopBottom'] =
        convertIntToDouble(secondDevicePositionTopBottom);
    data['secondDevicePositionRightLeft'] =
        convertIntToDouble(secondDevicePositionRightLeft);
    data['bodyRunSpacing'] = convertIntToDouble(bodyRunSpacing);
    data['bodySpacing'] = convertIntToDouble(bodySpacing);
    data['rotate'] = convertIntToDouble(rotate);
    data['secondRotate'] = convertIntToDouble(secondRotate);
    data['titlePaddingTop'] = convertIntToDouble(titlePaddingTop);
    data['titlePaddingBottom'] = convertIntToDouble(titlePaddingBottom);
    data['titlePaddingLeft'] = convertIntToDouble(titlePaddingLeft);
    data['titlePaddingRight'] = convertIntToDouble(titlePaddingRight);
    data['subtitlePaddingTop'] = convertIntToDouble(subtitlePaddingTop);
    data['subtitlePaddingBottom'] = convertIntToDouble(subtitlePaddingBottom);
    data['subtitlePaddingLeft'] = convertIntToDouble(subtitlePaddingLeft);
    data['subtitlePaddingRight'] = convertIntToDouble(subtitlePaddingRight);
    data['logoPaddingTop'] = convertIntToDouble(logoPaddingTop);
    data['logoPaddingBottom'] = convertIntToDouble(logoPaddingBottom);
    data['logoPaddingLeft'] = convertIntToDouble(logoPaddingLeft);
    data['logoPaddingRight'] = convertIntToDouble(logoPaddingRight);
    data['showLogo'] = showLogo;
    data['showSecondLogo'] = showSecondLogo;
    data['showTitle'] = showTitle;
    data['showSubtitle'] = showSubtitle;
    data['showDevice'] = showDevice;
    data['showSecondDevice'] = showSecondDevice;
    data['showFrame'] = showFrame;
    data['showSecondFrame'] = showSecondFrame;
    data['showStroke'] = showStroke;
    data['showSecondStroke'] = showSecondStroke;
    data['title'] = title;
    data['subtitle'] = subtitle;

    data['backgroundImage'] = backgroundImage;
    data['backgroundColor'] = backgroundColor != null
        ? ColorHelper.colorToHexWithoutHash(backgroundColor!)
        : null;

    data['backgroundGradient'] =
        backgroundGradient != null && backgroundGradient!.length == 2
            ? [
                ColorHelper.colorToHexWithoutHash(backgroundGradient![0]),
                ColorHelper.colorToHexWithoutHash(backgroundGradient![1]),
              ]
            : null;

    data['gradientAngle'] = convertIntToDouble(gradientAngle);
    data['strokeWidth'] = convertIntToDouble(strokeWidth);
    data['secondStrokeWidth'] = convertIntToDouble(secondStrokeWidth);

    data['strokeColor'] = strokeColor != null
        ? ColorHelper.colorToHexWithoutHash(strokeColor!)
        : null;

    data['secondStrokeColor'] = secondStrokeColor != null
        ? ColorHelper.colorToHexWithoutHash(secondStrokeColor!)
        : null;

    data['shadowColor'] = shadowColor != null
        ? ColorHelper.colorToHexWithoutHash(shadowColor!)
        : null;

    data['secondShadowColor'] = secondShadowColor != null
        ? ColorHelper.colorToHexWithoutHash(secondShadowColor!)
        : null;

    data['titleColor'] = titleColor != null
        ? ColorHelper.colorToHexWithoutHash(titleColor!)
        : null;

    data['subtitleColor'] = subtitleColor != null
        ? ColorHelper.colorToHexWithoutHash(subtitleColor!)
        : null;

    data['titleFontSize'] = convertIntToDouble(titleFontSize);
    data['titleLineHeight'] = convertIntToDouble(titleLineHeight);
    data['subtitleFontSize'] = convertIntToDouble(subtitleFontSize);
    data['subtitleLineHeight'] = convertIntToDouble(subtitleLineHeight);
    data['shadowBlur'] = convertIntToDouble(shadowBlur);
    data['secondShadowBlur'] = convertIntToDouble(secondShadowBlur);
    data['shadowOffsetX'] = convertIntToDouble(shadowOffsetX);
    data['shadowOffsetY'] = convertIntToDouble(shadowOffsetY);
    data['secondShadowOffsetX'] = convertIntToDouble(secondShadowOffsetX);
    data['secondShadowOffsetY'] = convertIntToDouble(secondShadowOffsetY);

    data['titleFontFamily'] = titleFontFamily;
    data['subtitleFontFamily'] = subtitleFontFamily;
    return data;
  }

  // convert to int to double
  double? convertIntToDouble(value) {
    if (value == null) {
      return null;
    }

    // if value is int
    if (value is double) {
      return value;
    }

    return value.toDouble();
  }

  // copy with
  TemplateConfigModel copyWith({
    String? id,
    String? logo,
    String? image,
    String? secondImage,
    String? type,
    String? firstDeviceFrame,
    String? secondDeviceFrame,
    Axis? bodyDirection,
    VerticalDirection? bodyVerticalDirection,
    WrapCrossAlignment? bodyCrossAxisAlignment,
    MainAxisAlignment? logoAlignment,
    MainAxisAlignment? titleAlignment,
    MainAxisAlignment? subtitleAlignment,
    double? firstDevicePositionTopBottom,
    double? firstDevicePositionRightLeft,
    double? secondDevicePositionTopBottom,
    double? secondDevicePositionRightLeft,
    double? bodyRunSpacing,
    double? bodySpacing,
    double? rotate,
    double? secondRotate,
    double? titlePaddingTop,
    double? titlePaddingBottom,
    double? titlePaddingLeft,
    double? titlePaddingRight,
    double? subtitlePaddingTop,
    double? subtitlePaddingBottom,
    double? subtitlePaddingLeft,
    double? subtitlePaddingRight,
    double? logoPaddingTop,
    double? logoPaddingBottom,
    double? logoPaddingLeft,
    double? logoPaddingRight,
    bool? deviceFullSize,
    bool? secondDeviceFullSize,
    bool? showLogo,
    bool? showSecondLogo,
    bool? showTitle,
    bool? showSubtitle,
    bool? showDevice,
    bool? showSecondDevice,
    bool? showFrame,
    bool? showSecondFrame,
    bool? showStroke,
    bool? showSecondStroke,
    String? title,
    String? subtitle,
    String? backgroundImage,
    Color? backgroundColor,
    List<Color>? backgroundGradient,
    double? gradientAngle,
    double? strokeWidth,
    double? secondStrokeWidth,
    double? titleFontSize,
    double? titleLineHeight,
    Color? titleColor,
    Color? titleStrokeColor,
    Color? strokeColor,
    Color? secondStrokeColor,
    Color? shadowColor,
    Color? secondShadowColor,
    String? titleFontFamily,
    double? subtitleFontSize,
    double? subtitleLineHeight,
    double? shadowBlur,
    double? secondShadowBlur,
    double? shadowOffsetX,
    double? shadowOffsetY,
    double? secondShadowOffsetX,
    double? secondShadowOffsetY,
    Color? subtitleColor,
    String? subtitleFontFamily,
  }) {
    return TemplateConfigModel(
      id: id ?? this.id,
      logo: logo ?? this.logo,
      image: image ?? this.image,
      secondImage: secondImage ?? this.secondImage,
      type: type ?? this.type,
      firstDeviceFrame: firstDeviceFrame ?? this.firstDeviceFrame,
      secondDeviceFrame: secondDeviceFrame ?? this.secondDeviceFrame,
      bodyDirection: bodyDirection ?? this.bodyDirection,
      bodyVerticalDirection:
          bodyVerticalDirection ?? this.bodyVerticalDirection,
      bodyCrossAxisAlignment:
          bodyCrossAxisAlignment ?? this.bodyCrossAxisAlignment,
      logoAlignment: logoAlignment ?? this.logoAlignment,
      titleAlignment: titleAlignment ?? this.titleAlignment,
      subtitleAlignment: subtitleAlignment ?? this.subtitleAlignment,
      firstDevicePositionTopBottom:
          firstDevicePositionTopBottom ?? this.firstDevicePositionTopBottom,
      firstDevicePositionRightLeft:
          firstDevicePositionRightLeft ?? this.firstDevicePositionRightLeft,
      secondDevicePositionTopBottom:
          secondDevicePositionTopBottom ?? this.secondDevicePositionTopBottom,
      secondDevicePositionRightLeft:
          secondDevicePositionRightLeft ?? this.secondDevicePositionRightLeft,
      bodyRunSpacing: bodyRunSpacing ?? this.bodyRunSpacing,
      bodySpacing: bodySpacing ?? this.bodySpacing,
      rotate: rotate ?? this.rotate,
      secondRotate: secondRotate ?? this.secondRotate,
      titlePaddingTop: titlePaddingTop ?? this.titlePaddingTop,
      titlePaddingBottom: titlePaddingBottom ?? this.titlePaddingBottom,
      titlePaddingLeft: titlePaddingLeft ?? this.titlePaddingLeft,
      titlePaddingRight: titlePaddingRight ?? this.titlePaddingRight,
      subtitlePaddingTop: subtitlePaddingTop ?? this.subtitlePaddingTop,
      subtitlePaddingBottom:
          subtitlePaddingBottom ?? this.subtitlePaddingBottom,
      subtitlePaddingLeft: subtitlePaddingLeft ?? this.subtitlePaddingLeft,
      subtitlePaddingRight: subtitlePaddingRight ?? this.subtitlePaddingRight,
      logoPaddingTop: logoPaddingTop ?? this.logoPaddingTop,
      logoPaddingBottom: logoPaddingBottom ?? this.logoPaddingBottom,
      logoPaddingLeft: logoPaddingLeft ?? this.logoPaddingLeft,
      logoPaddingRight: logoPaddingRight ?? this.logoPaddingRight,
      deviceFullSize: deviceFullSize ?? this.deviceFullSize,
      secondDeviceFullSize: secondDeviceFullSize ?? this.secondDeviceFullSize,
      showLogo: showLogo ?? this.showLogo,
      showSecondLogo: showSecondLogo ?? this.showSecondLogo,
      showTitle: showTitle ?? this.showTitle,
      showSubtitle: showSubtitle ?? this.showSubtitle,
      showDevice: showDevice ?? this.showDevice,
      showSecondDevice: showSecondDevice ?? this.showSecondDevice,
      showFrame: showFrame ?? this.showFrame,
      showSecondFrame: showSecondFrame ?? this.showSecondFrame,
      showStroke: showStroke ?? this.showStroke,
      showSecondStroke: showSecondStroke ?? this.showSecondStroke,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
      gradientAngle: gradientAngle ?? this.gradientAngle,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      secondStrokeWidth: secondStrokeWidth ?? this.secondStrokeWidth,
      strokeColor: strokeColor ?? this.strokeColor,
      secondStrokeColor: secondStrokeColor ?? this.secondStrokeColor,
      shadowColor: shadowColor ?? this.shadowColor,
      secondShadowColor: secondShadowColor ?? this.secondShadowColor,
      titleFontSize: titleFontSize ?? this.titleFontSize,
      titleLineHeight: titleLineHeight ?? this.titleLineHeight,
      titleColor: titleColor ?? this.titleColor,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      subtitleFontSize: subtitleFontSize ?? this.subtitleFontSize,
      subtitleLineHeight: subtitleLineHeight ?? this.subtitleLineHeight,
      shadowBlur: shadowBlur ?? this.shadowBlur,
      secondShadowBlur: secondShadowBlur ?? this.secondShadowBlur,
      shadowOffsetX: shadowOffsetX ?? this.shadowOffsetX,
      shadowOffsetY: shadowOffsetY ?? this.shadowOffsetY,
      secondShadowOffsetX: secondShadowOffsetX ?? this.secondShadowOffsetX,
      secondShadowOffsetY: secondShadowOffsetY ?? this.secondShadowOffsetY,
      titleFontFamily: titleFontFamily ?? this.titleFontFamily,
      subtitleFontFamily: subtitleFontFamily ?? this.subtitleFontFamily,
    );
  }
}
