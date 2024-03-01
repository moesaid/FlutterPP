import 'package:flutter/material.dart';

class BuildHoverWidget extends StatefulWidget {
  // function takes a bool value and returns a widget
  final Widget Function(bool)? child;
  const BuildHoverWidget({
    super.key,
    this.child,
  });

  @override
  State<BuildHoverWidget> createState() => _BuildHoverWidgetState();
}

class _BuildHoverWidgetState extends State<BuildHoverWidget> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHover = false;
        });
      },
      child: widget.child?.call(isHover) ?? const SizedBox.shrink(),
    );
  }
}
