import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Global/build_loading_page.dart';

class BuildLoadingSwitch extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final Duration? duration;
  final Widget? loadingWidget;

  const BuildLoadingSwitch({
    super.key,
    required this.isLoading,
    required this.child,
    this.duration,
    this.loadingWidget = const BuildLoadingPage(),
  });

  @override
  Widget build(BuildContext context) {
    // animation switch
    return AnimatedSwitcher(
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      duration: duration ?? const Duration(milliseconds: 500),
      child: isLoading ? loadingWidget : child,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
