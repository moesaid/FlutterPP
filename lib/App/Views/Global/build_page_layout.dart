import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BuildPageLayout extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const BuildPageLayout({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: padding ?? EdgeInsets.all(8.spa),
        child: child,
      ),
    );
  }
}
