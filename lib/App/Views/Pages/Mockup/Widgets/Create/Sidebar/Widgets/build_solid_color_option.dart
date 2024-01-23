import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/Sidebar/build_pick_color.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_sidebar_option.dart';

class BuildSolidColorOption extends StatelessWidget {
  final Color? initialColor;
  final void Function(Color)? onColorChangedCallback;
  const BuildSolidColorOption({
    super.key,
    this.initialColor,
    this.onColorChangedCallback,
  });

  @override
  Widget build(BuildContext context) {
    return BuildSidebarOption(
      title: 'Color',
      rightWidget: BuildPickColor(
        controllerTag: 'solidColor',
        initialColor: initialColor,
        onColorChangedCallback: onColorChangedCallback,
      ),
    );
  }
}
