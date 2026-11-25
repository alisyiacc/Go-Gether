import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

/// Stiker miring (rotasi dalam derajat) dengan border tegas.
class Sticker extends StatelessWidget {
  const Sticker({
    super.key,
    required this.text,
    required this.color,
    required this.angleDegrees,
    this.dashed = false,
    this.radius = 4,
    this.fontSize = 10.5,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  });

  final String text;
  final Color color;
  final double angleDegrees;
  final bool dashed;
  final double radius;
  final double fontSize;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final label = Text(
      text,
      style: GoogleFonts.plusJakartaSans(
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
        color: AppColors.ink,
        letterSpacing: 0.8,
      ),
    );

    final Widget body = dashed
        ? CustomPaint(
            painter: _DashedBorderPainter(
              color: AppColors.ink,
              fill: color,
              radius: radius,
            ),
            child: Padding(padding: padding, child: label),
          )
        : Container(
            padding: padding,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: AppColors.ink, width: 1.5),
            ),
            child: label,
          );

    return Transform.rotate(
      angle: angleDegrees * math.pi / 180,
      child: body,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({
    required this.color,
    required this.fill,
    required this.radius,
  });

  final Color color;
  final Color fill;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );

    canvas.drawRRect(rrect, Paint()..color = fill);

    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    const dash = 4.0;
    const gap = 3.0;
    final path = Path()..addRRect(rrect);
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final end = math.min(distance + dash, metric.length);
        canvas.drawPath(metric.extractPath(distance, end), stroke);
        distance += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter old) =>
      old.color != color || old.fill != fill || old.radius != radius;
}
