import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

/// Kartu putih berisi menu profil:
/// Verifikasi identitas, Rating & ulasan GO, Pengaturan akun.
class ProfileMenuCard extends StatelessWidget {
  const ProfileMenuCard({
    super.key,
    required this.isRegistered,
    required this.onReviewsTap,
    required this.onSettingsTap,
  });

  final bool isRegistered;
  final VoidCallback onReviewsTap;
  final VoidCallback onSettingsTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.inputBorder, width: 1.2),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _MenuRow(
            icon: Icons.shield_outlined,
            label: 'Verifikasi identitas',
            trailing: _StatusPill(registered: isRegistered),
          ),
          const _RowDivider(),
          _MenuRow(
            icon: Icons.star_outline_rounded,
            label: 'Rating & ulasan GO',
            onTap: onReviewsTap,
            trailing: const Icon(Icons.arrow_forward_rounded,
                size: 18, color: AppColors.ink),
          ),
          const _RowDivider(),
          _MenuRow(
            icon: Icons.settings_outlined,
            label: 'Pengaturan akun',
            onTap: onSettingsTap,
            trailing: const Icon(Icons.arrow_forward_rounded,
                size: 18, color: AppColors.ink),
          ),
        ],
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, thickness: 1, color: AppColors.divider);
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.icon,
    required this.label,
    required this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 19),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.ink),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.registered});

  final bool registered;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: registered ? AppColors.lime : AppColors.lavenderSoft,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        registered ? 'Registered' : 'Unregistered',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: registered ? AppColors.ink : AppColors.body,
        ),
      ),
    );
  }
}
