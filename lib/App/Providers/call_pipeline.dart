import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallPipeline {
  // futurePipeline is a function that takes a future and a name and returns a future
  Future<T?> futurePipeline<T>({
    required Future<T> Function() future,
    required String name,
  }) async {
    // try and catch AppwriteException and return the error message
    try {
      T res = await future();
      return res;
    } on AppwriteException catch (e) {
      print({
        'e': e,
        'message': e.message,
        'code': e.code,
        'type': e.type,
      });

      Get.snackbar(
        'error',
        e.type.toString() == 'user_already_exists'
            ? 'account already exists , try to login'
            : e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(20),
      );
      return null;
    } catch (e) {
      rethrow;
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
