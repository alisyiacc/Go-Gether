import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Tombol ikon kotak membulat (back, close, notifikasi) dengan badge opsional.
class IconSquareButton extends StatelessWidget {
  const IconSquareButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.showBadge = false,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool showBadge;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    Widget button = Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: AppColors.inputBorder, width: 1.2),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              width: 44,
              height: 44,
              child: Icon(icon, size: 22, color: AppColors.ink),
            ),
          ),
        ),
        if (showBadge)
          Positioned(
            top: 9,
            right: 10,
            child: Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: AppColors.alert,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 1.2),
              ),
            ),
          ),
      ],
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }
    return button;
  }
}
