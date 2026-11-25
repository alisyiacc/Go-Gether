import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Bintang 1-5. Bila [onChanged] diisi, bintang bisa diketuk.
class StarRating extends StatelessWidget {
  const StarRating({
    super.key,
    required this.value,
    this.size = 16,
    this.onChanged,
  });

  final int value;
  final double size;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    final interactive = onChanged != null;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 1; i <= 5; i++)
          GestureDetector(
            onTap: interactive ? () => onChanged!(i) : null,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: interactive ? 3 : 0),
              child: Icon(
                i <= value ? Icons.star_rounded : Icons.star_outline_rounded,
                size: size,
                color: i <= value ? AppColors.star : AppColors.hint,
              ),
            ),
          ),
      ],
    );
  }
}
