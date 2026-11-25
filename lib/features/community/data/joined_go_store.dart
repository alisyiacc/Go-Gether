import 'package:flutter/foundation.dart';

import '../../home/domain/go_group.dart';

/// Penyimpanan sementara (in-memory) GO yang diikuti user.
/// Hilang saat aplikasi ditutup — cukup untuk mode pratinjau.
class JoinedGoStore {
  JoinedGoStore._();

  static final ValueNotifier<List<GoGroup>> joined =
      ValueNotifier<List<GoGroup>>(<GoGroup>[]);

  static bool isJoined(GoGroup group) =>
      joined.value.any((g) => g.name == group.name);

  static void join(GoGroup group) {
    if (isJoined(group)) return;
    joined.value = [...joined.value, group];
  }

  static void leave(GoGroup group) {
    joined.value = joined.value.where((g) => g.name != group.name).toList();
  }
}
