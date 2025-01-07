enum StateManegmentEnum {
  getx,
  riverpod,
  bloc,
  provider,
  cubit;

  // return name
  String get name {
    return toString().split('.').last;
  }

  // from string to enum
  static StateManegmentEnum fromString(String name) {
    return StateManegmentEnum.values.firstWhere((e) => e.name == name);
  }

  // when
  Future<void> when({
    required StateManegmentEnum type,
    Future<void> Function()? getx,
    Future<void> Function()? riverpod,
    Future<void> Function()? bloc,
    Future<void> Function()? provider,
    Future<void> Function()? cubit,
  }) async {
    switch (type) {
      case StateManegmentEnum.getx:
        await getx?.call();
        break;
      case StateManegmentEnum.riverpod:
        await riverpod?.call();
        break;
      case StateManegmentEnum.bloc:
        await bloc?.call();
        break;
      case StateManegmentEnum.provider:
        await provider?.call();
        break;
      case StateManegmentEnum.cubit:
        await cubit?.call();
        break;
    }
  }
}
