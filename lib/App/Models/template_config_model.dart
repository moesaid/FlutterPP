import 'package:flutter/material.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';

class TemplateConfigModel {
  String? id, image;
  String? type;
  Axis? bodyDirection;
  VerticalDirection? bodyVerticalDirection;
  WrapCrossAlignment? bodyCrossAxisAlignment;
  MainAxisAlignment? logoAlignment;
  MainAxisAlignment? titleAlignment;
  MainAxisAlignment? subtitleAlignment;
  double? devicePositionTop;
  double? devicePositionLeft;
  double? devicePositionRight;
  double? devicePositionBottom;
  double? bodyRunSpacing;
  double? bodySpacing;
  double? rotate;
  double? titlePaddingTop;
  double? titlePaddingBottom;
  double? titlePaddingLeft;
  double? titlePaddingRight;
  double? subtitlePaddingTop;
  double? subtitlePaddingBottom;
  double? subtitlePaddingLeft;
  double? subtitlePaddingRight;
  double? logoPaddingTop;
  double? logoPaddingBottom;
  double? logoPaddingLeft;
  double? logoPaddingRight;
  bool? showLogo, deviceFullSize;
  bool? showTitle;
  bool? showSubtitle;
  String? title;
  String? subtitle;
  String? backgroundImage;
  Color? backgroundColor;
  List<Color>? backgroundGradient;

  TemplateConfigModel({
    this.id,
    this.image,
    this.type,
    this.bodyDirection,
    this.bodyVerticalDirection,
    this.bodyCrossAxisAlignment,
    this.logoAlignment,
    this.titleAlignment,
    this.subtitleAlignment,
    this.devicePositionTop,
    this.devicePositionLeft,
    this.devicePositionRight,
    this.devicePositionBottom,
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
    this.title,
    this.subtitle,
    this.backgroundImage,
    this.backgroundColor,
    this.backgroundGradient,
    this.deviceFullSize = false,
    this.showLogo = false,
    this.showTitle = false,
    this.showSubtitle = false,
  });

  TemplateConfigModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    type = json['type'];

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
    devicePositionTop = convertIntToDouble(json['devicePositionTop']);
    devicePositionLeft = convertIntToDouble(json['devicePositionLeft']);
    devicePositionRight = convertIntToDouble(json['devicePositionRight']);
    devicePositionBottom = convertIntToDouble(json['devicePositionBottom']);
    bodyRunSpacing = convertIntToDouble(json['bodyRunSpacing']);
    bodySpacing = convertIntToDouble(json['bodySpacing']);
    rotate = convertIntToDouble(json['rotate']);
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
    showTitle = json['showTitle'];
    showSubtitle = json['showSubtitle'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['type'] = type.toString();

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
    data['devicePositionTop'] = convertIntToDouble(devicePositionTop);
    data['devicePositionLeft'] = convertIntToDouble(devicePositionLeft);
    data['devicePositionRight'] = convertIntToDouble(devicePositionRight);
    data['devicePositionBottom'] = convertIntToDouble(devicePositionBottom);
    data['bodyRunSpacing'] = convertIntToDouble(bodyRunSpacing);
    data['bodySpacing'] = convertIntToDouble(bodySpacing);
    data['rotate'] = convertIntToDouble(rotate);
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
    data['showTitle'] = showTitle;
    data['showSubtitle'] = showSubtitle;
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
    String? image,
    String? type,
    Axis? bodyDirection,
    VerticalDirection? bodyVerticalDirection,
    WrapCrossAlignment? bodyCrossAxisAlignment,
    MainAxisAlignment? logoAlignment,
    MainAxisAlignment? titleAlignment,
    MainAxisAlignment? subtitleAlignment,
    double? devicePositionTop,
    double? devicePositionLeft,
    double? devicePositionRight,
    double? devicePositionBottom,
    double? bodyRunSpacing,
    double? bodySpacing,
    double? rotate,
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
    bool? showLogo,
    bool? deviceFullSize,
    bool? showTitle,
    bool? showSubtitle,
    String? title,
    String? subtitle,
    String? backgroundImage,
    Color? backgroundColor,
    List<Color>? backgroundGradient,
  }) {
    return TemplateConfigModel(
      id: id ?? this.id,
      image: image ?? this.image,
      type: type ?? this.type,
      bodyDirection: bodyDirection ?? this.bodyDirection,
      bodyVerticalDirection:
          bodyVerticalDirection ?? this.bodyVerticalDirection,
      bodyCrossAxisAlignment:
          bodyCrossAxisAlignment ?? this.bodyCrossAxisAlignment,
      logoAlignment: logoAlignment ?? this.logoAlignment,
      titleAlignment: titleAlignment ?? this.titleAlignment,
      subtitleAlignment: subtitleAlignment ?? this.subtitleAlignment,
      devicePositionTop: devicePositionTop ?? this.devicePositionTop,
      devicePositionLeft: devicePositionLeft ?? this.devicePositionLeft,
      devicePositionRight: devicePositionRight ?? this.devicePositionRight,
      devicePositionBottom: devicePositionBottom ?? this.devicePositionBottom,
      bodyRunSpacing: bodyRunSpacing ?? this.bodyRunSpacing,
      bodySpacing: bodySpacing ?? this.bodySpacing,
      rotate: rotate ?? this.rotate,
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
      showLogo: showLogo ?? this.showLogo,
      deviceFullSize: deviceFullSize ?? this.deviceFullSize,
      showTitle: showTitle ?? this.showTitle,
      showSubtitle: showSubtitle ?? this.showSubtitle,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
    );
  }
}
