import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Ikon mahkota garis (Material Icons tidak punya yang polos).
class CrownIcon extends StatelessWidget {
  const CrownIcon({super.key, this.size = 30, this.color = AppColors.ink});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _CrownPainter(color),
    );
  }
}

class _CrownPainter extends CustomPainter {
  _CrownPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final k = size.width / 24;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8 * k
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(4 * k, 17 * k)
      ..lineTo(3 * k, 7 * k)
      ..lineTo(8 * k, 11 * k)
      ..lineTo(12 * k, 5 * k)
      ..lineTo(16 * k, 11 * k)
      ..lineTo(21 * k, 7 * k)
      ..lineTo(20 * k, 17 * k)
      ..close()
      ..moveTo(4.5 * k, 20.5 * k)
      ..lineTo(19.5 * k, 20.5 * k);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CrownPainter old) => old.color != color;
}
