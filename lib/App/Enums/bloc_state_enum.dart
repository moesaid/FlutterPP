enum BlocStateEnum {
  bloc,
  cubit;

  // return name
  String get name {
    return toString().split('.').last;
  }

  // from string to enum
  static BlocStateEnum fromString(String name) {
    return BlocStateEnum.values.firstWhere((e) => e.name == name);
  }
}
