import '../../home/domain/go_group.dart';

/// Ulasan user untuk sebuah GO.
class GoReview {
  const GoReview({
    required this.group,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  final GoGroup group;
  final int rating; // 1..5
  final String comment;
  final DateTime createdAt;
}
