import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Ilustrasi kota malam bergaya neon sebagai latar kartu agenda
/// (dipakai selama belum ada foto asli).
class NeonCityArt extends StatelessWidget {
  const NeonCityArt({super.key, required this.seed, this.lanterns = false});

  final int seed;
  final bool lanterns;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _NeonCityPainter(seed: seed, lanterns: lanterns),
      size: Size.infinite,
    );
  }
}

class _NeonCityPainter extends CustomPainter {
  _NeonCityPainter({required this.seed, required this.lanterns});

  final int seed;
  final bool lanterns;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A1236), Color(0xFF3B1E5E), Color(0xFF120A22)],
        ).createShader(rect),
    );

    final rnd = math.Random(seed);
    final palette = lanterns
        ? const [
            Color(0xFF2EE6D6),
            Color(0xFF3A86FF),
            Color(0xFFFF5C5C),
            Color(0xFFFFB347),
          ]
        : const [
            Color(0xFFFF4FA3),
            Color(0xFF4FC3FF),
            Color(0xFFB388FF),
            Color(0xFFFFE66D),
          ];

    double x = -10;
    while (x < size.width) {
      final w = 38 + rnd.nextDouble() * 40;
      final h = size.height * (0.5 + rnd.nextDouble() * 0.45);
      final top = size.height - h;

      canvas.drawRect(
        Rect.fromLTWH(x, top, w - 3, h),
        Paint()
          ..color = Color.lerp(
            const Color(0xFF1B1030),
            const Color(0xFF2A1745),
            rnd.nextDouble(),
          )!
              .withValues(alpha: 0.92),
      );

      final signs = 2 + rnd.nextInt(3);
      for (int i = 0; i < signs; i++) {
        final sw = 8 + rnd.nextDouble() * (w * 0.5);
        final sh = 14 + rnd.nextDouble() * 34;
        final sx = x + 3 + rnd.nextDouble() * math.max(0.0, w - sw - 8);
        final sy = top + 6 + rnd.nextDouble() * (h * 0.7);
        final color = palette[rnd.nextInt(palette.length)];
        final r = Rect.fromLTWH(sx, sy, sw, sh);

        canvas.drawRect(
          r.inflate(3),
          Paint()
            ..color = color.withValues(alpha: 0.45)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 9),
        );
        canvas.drawRect(r, Paint()..color = color.withValues(alpha: 0.85));
      }
      x += w;
    }

    if (lanterns) {
      for (int i = 0; i < 9; i++) {
        final cx = rnd.nextDouble() * size.width;
        final cy = size.height * (0.12 + rnd.nextDouble() * 0.35);
        final r = 7 + rnd.nextDouble() * 5;
        canvas.drawCircle(
          Offset(cx, cy),
          r + 5,
          Paint()
            ..color = const Color(0xFFFF8A3D).withValues(alpha: 0.5)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
        );
        canvas.drawCircle(
          Offset(cx, cy),
          r,
          Paint()..color = const Color(0xFFFF6B3D),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _NeonCityPainter old) =>
      old.seed != seed || old.lanterns != lanterns;
}

/// Ilustrasi bokeh hangat sebagai latar banner detail GO.
class BokehArt extends StatelessWidget {
  const BokehArt({super.key, this.seed = 5});

  final int seed;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _BokehPainter(seed), size: Size.infinite);
  }
}

class _BokehPainter extends CustomPainter {
  _BokehPainter(this.seed);

  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFD9C79A), Color(0xFF8B6B4A), Color(0xFF2C2230)],
        ).createShader(rect),
    );

    final rnd = math.Random(seed);
    const colors = [
      Color(0xFFFFB3C7),
      Color(0xFF9BD1FF),
      Color(0xFFFFE08A),
      Color(0xFFC9B8F5),
    ];
    for (int i = 0; i < 16; i++) {
      canvas.drawCircle(
        Offset(rnd.nextDouble() * size.width, rnd.nextDouble() * size.height),
        8 + rnd.nextDouble() * 18,
        Paint()
          ..color = colors[rnd.nextInt(colors.length)].withValues(alpha: 0.5)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
      );
    }

    // Dua "figur" sederhana.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.28, size.height * 0.68),
        width: size.width * 0.2,
        height: size.height * 0.5,
      ),
      Paint()..color = const Color(0xFF1E1A24),
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.52, size.height * 0.62),
        width: size.width * 0.18,
        height: size.height * 0.56,
      ),
      Paint()..color = const Color(0xFFDAD6E0),
    );
  }

  @override
  bool shouldRepaint(covariant _BokehPainter old) => old.seed != seed;
}
