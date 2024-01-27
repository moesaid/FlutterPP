enum TemplateLayoutEnum {
  titleUp,
  titleDown,
  rightSideTitleAbove,
  leftSideTitleAbove,
  rightSideTitleBelow,
  leftSideTitleBelow;

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
