import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/gogether_logo.dart';
import 'passport_hero_card.dart';

/// Kerangka bersama halaman Sign in & Sign up:
/// logo, hero card, judul section, [children] (form), dan catatan pratinjau.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.stepLabel,
    required this.children,
  });

  final String title;
  final String stepLabel;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GogetherLogo(),
                  const SizedBox(height: 26),
                  const PassportHeroCard(),
                  const SizedBox(height: 40),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.6,
                            color: AppColors.ink,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(stepLabel, style: AppTheme.mono()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Divider(height: 1, thickness: 1.2, color: AppColors.divider),
                  const SizedBox(height: 22),
                  ...children,
                  const SizedBox(height: 22),
                  Center(
                    child: Text(
                      'Mode pratinjau UI. Tidak membuat akun sungguhan.\n'
                      'Email dan kata sandi tidak disimpan atau dikirim.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.5,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                        color: AppColors.muted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
