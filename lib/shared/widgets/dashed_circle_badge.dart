import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import 'sticker.dart';

/// Lencana lingkaran putus-putus "GO TOGETHER".
class DashedCircleBadge extends StatelessWidget {
  const DashedCircleBadge({super.key, this.size = 64});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -12 * math.pi / 180,
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: DashedBorderPainter(
            color: AppColors.ink,
            fill: Colors.transparent,
            radius: size / 2,
          ),
          child: Center(
            child: Text(
              'GO\nTOGETHER',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 8.5,
                height: 1.25,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
                color: AppColors.ink,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
