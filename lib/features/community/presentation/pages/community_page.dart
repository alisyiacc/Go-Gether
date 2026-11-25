import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/sticker.dart';
import '../../../explore/presentation/widgets/explore_go_card.dart';
import '../../../home/domain/go_group.dart';
import '../../../home/presentation/widgets/go_detail_sheet.dart';
import '../../../shell/presentation/main_shell.dart';
import '../../data/joined_go_store.dart';
import '../widgets/community_empty_state.dart';
import '../widgets/community_tabs.dart';
import '../widgets/crown_icon.dart';
import '../widgets/seller_registration_sheet.dart';

/// Tab Komunitas: GO yang diikuti + pendaftaran jadi seller.
class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: ValueListenableBuilder<List<GoGroup>>(
              valueListenable: JoinedGoStore.joined,
              builder: (context, joined, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 2),
                      child: Sticker(
                        text: 'MY COMMUNITY',
                        color: AppColors.salmon,
                        angleDegrees: -3,
                        fontSize: 10,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Your little circle.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.9,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CommunityTabs(
                      labels: ['Joined GO (${joined.length})', 'Your GO'],
                      index: _tab,
                      onChanged: (i) => setState(() => _tab = i),
                    ),
                    const SizedBox(height: 16),
                    if (_tab == 0)
                      ..._joinedTab(context, joined)
                    else
                      _yourGoTab(context),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _joinedTab(BuildContext context, List<GoGroup> joined) {
    if (joined.isEmpty) {
      return [
        CommunityEmptyState(
          icon: const Icon(Icons.people_outline,
              size: 32, color: AppColors.ink),
          title: 'Circle-mu menunggu.',
          description:
              'Cari fandom yang kamu suka, kenali seller, lalu tentukan mau '
              'gabung ke mana.',
          buttonLabel: 'Temukan GO',
          // Arahkan ke tab Jelajah.
          onPressed: () => mainTabIndex.value = 1,
        ),
      ];
    }
    return [
      for (final group in joined) ...[
        ExploreGoCard(
          group: group,
          onTap: () => showGoDetailSheet(context, group),
        ),
        const SizedBox(height: 12),
      ],
    ];
  }

  Widget _yourGoTab(BuildContext context) {
    return CommunityEmptyState(
      icon: const CrownIcon(size: 32),
      title: 'GO pertamamu?',
      description:
          'Punya akses merch luar negeri? Lengkapi data calon seller dan '
          'mulai dari sini.',
      buttonLabel: 'Daftar jadi seller',
      onPressed: () => showSellerRegistrationSheet(context),
    );
  }
}
