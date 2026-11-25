import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/sticker.dart';

/// Kartu hero gelap "Jauh merchnya. Dekat circle-nya." beserta dua stiker.
class PassportHeroCard extends StatelessWidget {
  const PassportHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    final headline = GoogleFonts.plusJakartaSans(
      fontSize: 40,
      fontWeight: FontWeight.w800,
      height: 0.98,
      letterSpacing: -1.8,
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(22, 26, 22, 26),
          decoration: BoxDecoration(
            color: AppColors.ink,
            borderRadius: BorderRadius.circular(26),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jauh merchnya.',
                style: headline.copyWith(color: AppColors.white),
              ),
              Text(
                'Dekat circle-\nnya.',
                style: headline.copyWith(color: AppColors.lime),
              ),
              const SizedBox(height: 16),
              Text(
                'Temukan GO, kenalan sama seller, dan kumpulkan hal yang kamu suka.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                  color: AppColors.heroSubtitle,
                ),
              ),
            ],
          ),
        ),
        const Positioned(
          top: -16,
          right: -6,
          child: Sticker(
            text: 'FANDOM, MEET FRIENDS.',
            color: AppColors.lime,
            angleDegrees: 4,
          ),
        ),
        const Positioned(
          bottom: -22,
          right: 6,
          child: Sticker(
            text: 'JP / KR / TH / CN',
            color: AppColors.salmon,
            angleDegrees: -8,
            dashed: true,
            radius: 16,
            fontSize: 11.5,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
          ),
        ),
      ],
    );
  }
}