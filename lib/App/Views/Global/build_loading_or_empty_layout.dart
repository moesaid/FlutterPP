import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Global/build_empty_page.dart';
import 'package:flutterpp/App/Views/Global/build_loading_switch.dart';

class BuildLoadingOrEmptyLayout extends StatelessWidget {
  final bool isLoading, isEmpty;
  final bool? hasButton;
  final String? buttonText, title;
  final VoidCallback? onButtonPressed;
  final Widget child;

  const BuildLoadingOrEmptyLayout({
    super.key,
    required this.isLoading,
    required this.isEmpty,
    required this.child,
    this.hasButton,
    this.buttonText,
    this.onButtonPressed,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BuildLoadingSwitch(
      isLoading: isLoading,
      child: isEmpty
          ? BuildEmptyPage(
              hasButton: hasButton,
              buttonTitle: buttonText,
              onTap: onButtonPressed,
              title: title,
            )
          : child,
    );
  }
}
