enum TemplateLayoutEnum {
  titleUp,
  titleDown,
  rightSideTitleAbove,
  leftSideTitleAbove,
  rightSideTitleBelow,
  leftSideTitleBelow,
  rotateRightOne,
  rotateRightTwo,
  rotateRightThree,
  rotateRightFour,
  twoDevicesTitleAbove,
  twoDevicesTitleBelow,
  twoDevicesTopLeftBottomRight,
  twoDevicesTopRightBottomLeft,
  twoDevicesConnectedRightTitleAbove,
  twoDevicesConnectedLeftTitleAbove;

  // get name
  String get name {
    return toString().split('.').last;
  }

  // from string to enum
  static TemplateLayoutEnum fromString(String name) {
    return TemplateLayoutEnum.values.firstWhere((e) => e.name == name);
  }

  // return all enums
  static List<TemplateLayoutEnum> get all {
    return TemplateLayoutEnum.values;
  }
}
