import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../home/domain/go_group.dart';
import '../../../home/presentation/widgets/go_avatar.dart';

/// Kartu hasil pencarian GO (tanpa nomor peringkat).
class ExploreGoCard extends StatelessWidget {
  const ExploreGoCard({super.key, required this.group, required this.onTap});

  final GoGroup group;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final metaStyle = GoogleFonts.plusJakartaSans(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: AppColors.ink,
    );

    return Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColors.inputBorder, width: 1.2),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
          child: Column(
            children: [
              Row(
                children: [
                  GoAvatar(
                    initials: group.initials,
                    color: group.avatarColor,
                    size: 50,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          group.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${group.category} · ${group.country}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1, thickness: 1, color: AppColors.divider),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.people_outline,
                      size: 16, color: AppColors.ink),
                  const SizedBox(width: 6),
                  Text('${group.members} anggota', style: metaStyle),
                  const SizedBox(width: 16),
                  const Icon(Icons.star_rounded,
                      size: 16, color: AppColors.star),
                  const SizedBox(width: 4),
                  Text('${group.rating} (${group.reviews})',
                      style: metaStyle),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_rounded,
                      size: 16, color: AppColors.ink),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
