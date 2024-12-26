import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:collection';

class RiverPod {
  static Provider<T> provider<T>(
    String key,
    T Function(Ref ref) createFn,
  ) {
    return _providerCache.update(
      key,
      (value) => value,
      ifAbsent: () => Provider<T>(createFn),
    );
  }

  static final _providerCache = LinkedHashMap<String, dynamic>.identity();
}
