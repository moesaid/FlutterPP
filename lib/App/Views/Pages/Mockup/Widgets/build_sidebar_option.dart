import 'package:flutter/material.dart';

class BuildSidebarOption extends StatelessWidget {
  final Widget? leftWidget, rightWidget;
  final int? flexLeft, flexRight;
  final String? title;
  const BuildSidebarOption({
    super.key,
    this.leftWidget,
    this.rightWidget,
    this.flexLeft,
    this.flexRight,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: flexLeft ?? 4,
          child: leftWidget ??
              Text(
                title ?? 'Type',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        Expanded(
          flex: flexRight ?? 6,
          child: rightWidget ?? const Text('2'),
        ),
      ],
    );
  }
}
