import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/sticker.dart';

/// Kartu gelap profil: avatar, nama, tagline, dan jumlah GO yang diikuti.
class ProfileHeroCard extends StatelessWidget {
  const ProfileHeroCard({
    super.key,
    required this.name,
    required this.joinedCount,
  });

  final String name;
  final int joinedCount;

  String get _initials {
    final t = name.trim();
    if (t.isEmpty) return 'GO';
    return t.substring(0, math.min(2, t.length)).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.lavenderChip,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  _initials,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.6,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tempat cerita dan koleksi bertemu.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.heroSubtitle,
                ),
              ),
              const SizedBox(height: 16),
              Container(height: 1, color: Colors.white.withValues(alpha: 0.2)),
              const SizedBox(height: 12),
              Text(
                '$joinedCount GO pernah diikuti',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Transform.rotate(
              angle: 8 * math.pi / 180,
              child: CustomPaint(
                painter: DashedBorderPainter(
                  color: AppColors.heroLabel,
                  fill: Colors.transparent,
                  radius: 16,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                  child: Text(
                    'GO / ID',
                    style: AppTheme.mono(
                      fontSize: 10.5,
                      color: AppColors.heroLabel,
                      letterSpacing: 1.4,
                    ),
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
