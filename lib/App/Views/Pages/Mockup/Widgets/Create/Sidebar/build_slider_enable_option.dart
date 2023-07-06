import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_sidebar_option.dart';

class BuildSliderEnableOption extends StatelessWidget {
  const BuildSliderEnableOption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BuildSidebarOption(
      title: 'Enable',
      rightWidget: Switch(
        value: true,
        onChanged: (bool value) {
          print(value);
        },
      ),
    );
  }
}
