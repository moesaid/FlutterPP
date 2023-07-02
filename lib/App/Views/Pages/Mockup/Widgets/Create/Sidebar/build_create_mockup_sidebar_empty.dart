import 'package:flutter/material.dart';

class BuildCreateMockupSidebarEmpty extends StatelessWidget {
  const BuildCreateMockupSidebarEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Select a screenshot',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
