import 'package:flutter/material.dart';

class BuildLogo extends StatelessWidget {
  final double? size;
  const BuildLogo({
    super.key,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      height: size ?? 30,
    );
  }
}
