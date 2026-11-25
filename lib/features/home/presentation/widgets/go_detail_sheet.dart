import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/icon_square_button.dart';
import '../../../community/data/joined_go_store.dart';
import '../../domain/go_group.dart';
import 'go_avatar.dart';
import 'neon_art.dart';

/// Bottom sheet "Kenalan dulu sama GO-nya."
Future<void> showGoDetailSheet(BuildContext context, GoGroup group) {
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
    builder: (_) => _GoDetailSheet(group: group),
  );
}

class _GoDetailSheet extends StatelessWidget {
  const _GoDetailSheet({required this.group});

  final GoGroup group;

  @override
  Widget build(BuildContext context) {
    final joined = JoinedGoStore.isJoined(group);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Kenalan dulu sama GO-nya.',
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
          const SizedBox(height: 18),
          Row(
            children: [
              GoAvatar(
                initials: group.initials,
                color: group.avatarColor,
                size: 54,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.name,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Text(
                          'oleh ${group.seller}',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.muted,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(Icons.verified_outlined,
                            size: 15, color: AppColors.purple),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 132,
              width: double.infinity,
              child: group.image != null
                  ? Image(image: group.image!, fit: BoxFit.cover)
                  : const BokehArt(),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.lavenderSoft,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${group.series} · ${group.category}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${group.country} · ${group.members} anggota',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.muted,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        size: 16, color: AppColors.star),
                    const SizedBox(width: 4),
                    Text(
                      '${group.rating} / 5 · ${group.reviews} ulasan',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text(
            group.description,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.5,
              height: 1.5,
              fontWeight: FontWeight.w500,
              color: AppColors.body,
            ),
          ),
          const SizedBox(height: 18),
          Material(
            color: joined ? AppColors.white : AppColors.lime,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: joined
                  ? const BorderSide(color: AppColors.inputBorder, width: 1.2)
                  : BorderSide.none,
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                final messenger = ScaffoldMessenger.of(context);
                if (joined) {
                  JoinedGoStore.leave(group);
                } else {
                  JoinedGoStore.join(group);
                }
                Navigator.of(context).pop();
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      joined
                          ? 'Kamu keluar dari ${group.name}.'
                          : 'Kamu bergabung ke ${group.name}.',
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      joined ? Icons.logout_rounded : Icons.people_outline,
                      size: 18,
                      color: AppColors.ink,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      joined ? 'Keluar dari GO' : 'Ya, gabung GO ini',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                joined ? 'Tutup' : 'Lihat-lihat dulu',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
