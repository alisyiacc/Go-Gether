import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';

/// Tombol penuh berwarna gelap. [onPressed] null = nonaktif (warna pudar).
class DarkButton extends StatelessWidget {
  const DarkButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.showArrow = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: enabled ? AppColors.ink : const Color(0xFF7A6577),
        borderRadius: BorderRadius.circular(14),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                if (showArrow) ...[
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded,
                      size: 17, color: Colors.white),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
