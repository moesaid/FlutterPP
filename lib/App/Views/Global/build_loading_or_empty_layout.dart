import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Global/build_loading_switch.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/mockup_index_page.dart';

class BuildLoadingOrEmptyLayout extends StatelessWidget {
  final bool isLoading, isEmpty;
  final Widget child;

  const BuildLoadingOrEmptyLayout({
    super.key,
    required this.isLoading,
    required this.isEmpty,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BuildLoadingSwitch(
      isLoading: isLoading,
      child: isEmpty ? const BuildEmptyPage() : child,
    );
  }
}
