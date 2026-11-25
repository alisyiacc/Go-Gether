import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/dark_button.dart';
import '../../../../shared/widgets/icon_square_button.dart';
import '../../../community/data/joined_go_store.dart';
import '../../../home/domain/go_group.dart';
import '../../../home/presentation/widgets/go_avatar.dart';
import '../../data/review_store.dart';
import '../../domain/go_review.dart';
import 'star_rating.dart';

/// Pop-up "Cerita dari circle-mu".
/// - Belum join GO & belum ada ulasan: pesan ajakan bergabung.
/// - Sudah join: daftar GO yang bisa diulas.
/// - Sudah ada ulasan: riwayat ulasan.
Future<void> showReviewsSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.background,
    constraints: const BoxConstraints(maxWidth: 520),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      side: BorderSide(color: AppColors.ink, width: 1.2),
    ),
    builder: (_) => const _ReviewsSheet(),
  );
}

class _ReviewsSheet extends StatefulWidget {
  const _ReviewsSheet();

  @override
  State<_ReviewsSheet> createState() => _ReviewsSheetState();
}

class _ReviewsSheetState extends State<_ReviewsSheet> {
  GoGroup? _reviewing;
  int _rating = 0;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _startReview(GoGroup group) {
    setState(() {
      _reviewing = group;
      _rating = 0;
      _commentController.clear();
    });
  }

  void _submit() {
    final group = _reviewing;
    if (group == null || _rating == 0) return;
    ReviewStore.add(
      GoReview(
        group: group,
        rating: _rating,
        comment: _commentController.text.trim(),
        createdAt: DateTime.now(),
      ),
    );
    setState(() => _reviewing = null);
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/'
      '${d.month.toString().padLeft(2, '0')}/${d.year}';

  TextStyle get _labelStyle => GoogleFonts.plusJakartaSans(
        fontSize: 13.5,
        fontWeight: FontWeight.w800,
        color: AppColors.ink,
      );

  TextStyle get _bodyStyle => GoogleFonts.plusJakartaSans(
        fontSize: 13.5,
        height: 1.5,
        fontWeight: FontWeight.w500,
        color: AppColors.body,
      );

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 100),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
        child: ListenableBuilder(
          listenable: Listenable.merge([
            JoinedGoStore.joined,
            ReviewStore.reviews,
          ]),
          builder: (context, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Cerita dari circle-mu',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.4,
                          color: AppColors.ink,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconSquareButton(
                      icon: Icons.close_rounded,
                      tooltip: 'Tutup',
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (_reviewing != null)
                  ..._reviewForm(_reviewing!)
                else
                  ..._overview(),
              ],
            );
          },
        ),
      ),
    );
  }

  // ----- tampilan utama -----
  List<Widget> _overview() {
    final joined = JoinedGoStore.joined.value;
    final reviews = ReviewStore.reviews.value;
    final pending = joined.where((g) => !ReviewStore.hasReviewed(g)).toList();

    if (joined.isEmpty && reviews.isEmpty) {
      return [
        Text(
          'Belum ada GO yang pernah kamu ikuti. Gabung GO dulu untuk '
          'berbagi pengalaman.',
          style: _bodyStyle,
        ),
      ];
    }

    return [
      if (reviews.isNotEmpty) ...[
        Text('Riwayat ulasanmu', style: _labelStyle),
        const SizedBox(height: 10),
        for (final r in reviews) ...[
          _ReviewCard(review: r, date: _formatDate(r.createdAt)),
          const SizedBox(height: 10),
        ],
      ],
      if (pending.isNotEmpty) ...[
        if (reviews.isNotEmpty) const SizedBox(height: 8),
        Text('Belum kamu ulas', style: _labelStyle),
        const SizedBox(height: 4),
        Text(
          'Ceritakan pengalamanmu supaya circle lain bisa mengenal GO ini.',
          style: _bodyStyle.copyWith(fontSize: 12.5),
        ),
        const SizedBox(height: 10),
        for (final g in pending) ...[
          _PendingRow(group: g, onTap: () => _startReview(g)),
          const SizedBox(height: 10),
        ],
      ],
    ];
  }

  // ----- formulir ulasan -----
  List<Widget> _reviewForm(GoGroup group) {
    return [
      Row(
        children: [
          GoAvatar(
            initials: group.initials,
            color: group.avatarColor,
            size: 46,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.name,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
                Text(
                  '${group.category} · ${group.country}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.5,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 18),
      Text('Rating', style: _labelStyle),
      const SizedBox(height: 8),
      StarRating(
        value: _rating,
        size: 34,
        onChanged: (v) => setState(() => _rating = v),
      ),
      const SizedBox(height: 16),
      Text('Ceritakan pengalamanmu', style: _labelStyle),
      const SizedBox(height: 8),
      TextField(
        controller: _commentController,
        minLines: 3,
        maxLines: 5,
        cursorColor: AppColors.ink,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.ink,
        ),
        decoration: InputDecoration(
          hintText: 'Seller ramah, info barang jelas, dan pengiriman rapi.',
          hintStyle: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.hint,
          ),
          filled: true,
          fillColor: AppColors.white,
          contentPadding: const EdgeInsets.all(16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                const BorderSide(color: AppColors.inputBorder, width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.ink, width: 1.2),
          ),
        ),
      ),
      const SizedBox(height: 18),
      DarkButton(
        label: 'Kirim ulasan',
        showArrow: false,
        onPressed: _rating > 0 ? _submit : null,
      ),
      const SizedBox(height: 4),
      SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: () => setState(() => _reviewing = null),
          child: Text(
            'Batal',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
        ),
      ),
    ];
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review, required this.date});

  final GoReview review;
  final String date;

  @override
  Widget build(BuildContext context) {
    final g = review.group;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.inputBorder, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GoAvatar(initials: g.initials, color: g.avatarColor, size: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      g.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 2),
                    StarRating(value: review.rating, size: 16),
                  ],
                ),
              ),
              Text(
                date,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11.5,
                  color: AppColors.muted,
                ),
              ),
            ],
          ),
          if (review.comment.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              review.comment,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.5,
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: AppColors.body,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PendingRow extends StatelessWidget {
  const _PendingRow({required this.group, required this.onTap});

  final GoGroup group;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.inputBorder, width: 1.2),
      ),
      child: Row(
        children: [
          GoAvatar(
            initials: group.initials,
            color: group.avatarColor,
            size: 42,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
                Text(
                  group.category,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.5,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: AppColors.lime,
            borderRadius: BorderRadius.circular(12),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Text(
                  'Tulis ulasan',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
