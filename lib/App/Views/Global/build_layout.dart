import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Global/build_rail.dart';

class BuildLayout extends StatelessWidget {
  const BuildLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const BuildRail(),
          Expanded(
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
