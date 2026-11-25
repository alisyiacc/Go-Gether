import 'package:flutter/material.dart';

import '../../../../shared/widgets/gogether_logo.dart';
import '../../../../shared/widgets/icon_square_button.dart';

/// Baris atas beranda: logo + tombol notifikasi.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.onBellTap});

  final VoidCallback onBellTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const GogetherLogo(),
        IconSquareButton(
          icon: Icons.notifications_none_rounded,
          showBadge: true,
          tooltip: 'Notifikasi',
          onTap: onBellTap,
        ),
      ],
    );
  }
}
