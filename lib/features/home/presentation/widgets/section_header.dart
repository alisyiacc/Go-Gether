import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/sticker.dart';

/// Stiker kecil + judul section + widget opsional di kanan.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.stickerText,
    required this.stickerColor,
    required this.title,
    this.stickerAngle = -3,
    this.trailing,
  });

  final String stickerText;
  final Color stickerColor;
  final double stickerAngle;
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Sticker(
            text: stickerText,
            color: stickerColor,
            angleDegrees: stickerAngle,
            fontSize: 10,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: AppColors.ink,
                ),
              ),
            ),
            ?trailing,
          ],
        ),
      ],
    );
  }
}

/// Tautan bergaris bawah seperti "Lihat semua".
class UnderlinedLink extends StatelessWidget {
  const UnderlinedLink({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.only(bottom: 1),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.ink, width: 1.5),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
      ),
    );
  }
}
