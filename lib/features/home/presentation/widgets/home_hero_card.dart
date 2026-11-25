import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/dashed_circle_badge.dart';

/// Kartu sapaan lavender "Satu fandom. Satu tujuan."
class HomeHeroCard extends StatelessWidget {
  const HomeHeroCard({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    final headline = GoogleFonts.plusJakartaSans(
      fontSize: 32,
      fontWeight: FontWeight.w800,
      height: 1.02,
      letterSpacing: -1.2,
      color: AppColors.ink,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
      decoration: BoxDecoration(
        color: AppColors.lavender,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.ink, width: 1.2),
        boxShadow: const [
          BoxShadow(color: AppColors.ink, offset: Offset(2, 3)),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Halo, $userName. Ada yang kamu incar?',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.body,
                ),
              ),
              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  style: headline,
                  children: [
                    const TextSpan(text: 'Satu fandom.\nSatu '),
                    TextSpan(
                      text: 'tujuan.',
                      style: headline.copyWith(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Positioned(
            right: 0,
            top: 34,
            child: DashedCircleBadge(size: 64),
          ),
        ],
      ),
    );
  }
}
