import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/dark_button.dart';
import '../../../../shared/widgets/sticker.dart';

/// Kartu kosong putus-putus dengan ikon miring, judul, deskripsi, dan tombol.
class CommunityEmptyState extends StatelessWidget {
  const CommunityEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.onPressed,
  });

  final Widget icon;
  final String title;
  final String description;
  final String buttonLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: const Color(0xFFB9A9C6),
        fill: const Color(0xFFEFE8F4),
        radius: 18,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 22),
        child: Column(
          children: [
            Transform.rotate(
              angle: -10 * math.pi / 180,
              child: Container(
                width: 76,
                height: 76,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.lavenderChip,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.ink, width: 1.5),
                  boxShadow: const [
                    BoxShadow(color: AppColors.ink, offset: Offset(3, 4)),
                  ],
                ),
                child: icon,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.5,
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: AppColors.body,
              ),
            ),
            const SizedBox(height: 22),
            DarkButton(label: buttonLabel, onPressed: onPressed),
          ],
        ),
      ),
    );
  }
}
