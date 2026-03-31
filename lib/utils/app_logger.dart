import 'package:flutter/foundation.dart';

class Console {
  static void log(Object? message) {
    if (kDebugMode) {
      debugPrint('[Console] $message');
    }
  }

  static void error(Object? message) {
    if (kDebugMode) {
      debugPrint('[Console][Error] $message');
    }
  }
}
