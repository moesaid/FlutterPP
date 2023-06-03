import 'package:flutter/material.dart';

class BuildPageLayout extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const BuildPageLayout({
    Key? key,
    required this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(25),
      //   child: Container(height: 25),
      // ),
      body: Padding(
        padding: padding ?? const EdgeInsets.all(20),
        child: child,
      ),
    );
  }
}
