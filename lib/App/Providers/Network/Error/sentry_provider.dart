import 'dart:typed_data';

import 'package:feedback/feedback.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SentryProvider {
  SupabaseClient supabase = Supabase.instance.client;

  // captureMessage with screenshot
  Future<void> captureUserFeedback({
    String? message,
    UserFeedback? feedback,
    required Uint8List bytes,
  }) async {
    await Sentry.captureMessage(
      message ?? '',
      withScope: (scope) {
        final entries = feedback?.extra?.entries;
        if (entries != null) {
          for (final extra in entries) {
            scope.setExtra(extra.key, extra.value);
          }
        }
        scope.setUser(
          SentryUser(
            id: supabase.auth.currentUser?.id,
            email: supabase.auth.currentUser?.email,
          ),
        );

        scope.addAttachment(SentryAttachment.fromScreenshotData(bytes));
      },
    );
  }
}
