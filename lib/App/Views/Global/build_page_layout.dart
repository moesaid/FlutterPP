import 'package:flutter/material.dart';

class ByukdPageLayout extends StatelessWidget {
  final Widget child;
  const ByukdPageLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(25),
        child: Container(height: 25),
      ),
      body: child,
    );
  }
}
