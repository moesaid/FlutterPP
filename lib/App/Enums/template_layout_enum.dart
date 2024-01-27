enum TemplateLayoutEnum {
  titleUp,
  titleDown,
  rightSideTitleAbove,
  leftSideTitleAbove;

  // get name
  String get name {
    return toString().split('.').last;
  }

  // from string to enum
  static TemplateLayoutEnum fromString(String name) {
    return TemplateLayoutEnum.values.firstWhere((e) => e.name == name);
  }
}
