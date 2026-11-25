import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/gogether_logo.dart';
import 'passport_hero_card.dart';

/// Kerangka bersama halaman Sign in & Sign up:
/// logo, hero card, [children] (form), dan catatan kecil [footnote].
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.footnote,
    required this.children,
  });

  final String footnote;
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
                  const SizedBox(height: 44),
                  ...children,
                  const SizedBox(height: 22),
                  Center(
                    child: Text(
                      footnote,
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