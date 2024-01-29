import 'package:flutter/material.dart';
import 'package:flutterpp/App/Views/Global/build_time_overlay.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BuildTimeOverlay(),
          ],
        ),
      ),
    );
  }
}
