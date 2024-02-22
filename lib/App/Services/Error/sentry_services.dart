import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Providers/Network/Error/sentry_provider.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:get/get.dart';

class SentryServices {
  SentryProvider sentryProvider = SentryProvider();

  // send feedback
  Future<void> captureUserFeedback({required BuildContext context}) async {
    BetterFeedback.of(context).show((feedback) async {
      Get.showOverlay(
        asyncFunction: () async {
          await SentryProvider().captureUserFeedback(
            message: feedback.text,
            bytes: feedback.screenshot,
            feedback: feedback,
          );
        },
        loadingWidget: const BuildOverlay(),
      );
    });
  }
}
