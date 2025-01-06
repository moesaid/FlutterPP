enum BackgroundEnum {
  solid,
  gradient,
  image;

  // getter for ids
  String get id {
    switch (this) {
      case BackgroundEnum.solid:
        return 'solid';
      case BackgroundEnum.gradient:
        return 'gradient';
      case BackgroundEnum.image:
        return 'image';
    }
  }
}
