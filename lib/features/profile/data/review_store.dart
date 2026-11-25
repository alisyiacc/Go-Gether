import 'package:flutter/foundation.dart';

import '../../home/domain/go_group.dart';
import '../domain/go_review.dart';

/// Riwayat ulasan user (in-memory). Satu GO hanya punya satu ulasan.
class ReviewStore {
  ReviewStore._();

  static final ValueNotifier<List<GoReview>> reviews =
      ValueNotifier<List<GoReview>>(<GoReview>[]);

  static bool hasReviewed(GoGroup group) =>
      reviews.value.any((r) => r.group.name == group.name);

  static void add(GoReview review) {
    reviews.value = [
      review,
      ...reviews.value.where((r) => r.group.name != review.group.name),
    ];
  }
}
