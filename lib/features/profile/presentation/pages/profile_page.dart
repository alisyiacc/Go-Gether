import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/sticker.dart';
import '../../../community/data/joined_go_store.dart';
import '../../../community/data/seller_status_store.dart';
import '../../data/profile_store.dart';
import '../widgets/profile_hero_card.dart';
import '../widgets/profile_menu_card.dart';
import '../widgets/reviews_sheet.dart';
import '../widgets/settings_sheet.dart';

/// Tab Profil.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: ListenableBuilder(
              listenable: Listenable.merge([
                ProfileStore.name,
                JoinedGoStore.joined,
                SellerStatusStore.registered,
              ]),
              builder: (context, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 2),
                      child: Sticker(
                        text: 'ALL ABOUT YOU',
                        color: AppColors.lime,
                        angleDegrees: -3,
                        fontSize: 10,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Profil.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.9,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ProfileHeroCard(
                      name: ProfileStore.name.value,
                      joinedCount: JoinedGoStore.joined.value.length,
                    ),
                    const SizedBox(height: 16),
                    ProfileMenuCard(
                      isRegistered: SellerStatusStore.registered.value,
                      onReviewsTap: () => showReviewsSheet(context),
                      onSettingsTap: () => showSettingsSheet(context),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Registered berarti data pendaftaran sellermu sudah '
                      'kami terima. Unregistered berarti kamu belum '
                      'mendaftar sebagai seller.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                        color: AppColors.body,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
