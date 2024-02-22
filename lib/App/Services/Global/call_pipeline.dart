import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CallPipeline {
  // futurePipeline is a function that takes a future and a name and returns a future
  Future<T?> futurePipeline<T>({
    required Future<T?> Function() future,
    required String name,
  }) async {
    try {
      T? res = await future();
      return res;
    } catch (exception, stackTrace) {
      // print({'❌exception': exception, 'stackTrace': stackTrace});

      User? user = Supabase.instance.client.auth.currentUser;

      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
        withScope: (scope) {
          scope.setUser(
            SentryUser(
              id: user?.id,
              email: user?.email,
            ),
          );
        },
      );

      return null;
    }
  }

  // streamPipeline is a function that takes a stream and a name and returns a stream
  Stream<T?> streamPipeline<T>({
    required Stream<T> Function() stream,
    required String name,
  }) async* {
    try {
      Stream<T> res = stream();
      yield* res;
    } catch (e) {
      rethrow;
    }
  }
}
