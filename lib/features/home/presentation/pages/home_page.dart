import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/home_mock_data.dart';
import '../widgets/go_detail_sheet.dart';
import '../widgets/home_header.dart';
import '../widgets/home_hero_card.dart';
import '../widgets/popup_event_card.dart';
import '../widgets/section_header.dart';
import '../widgets/top_go_card.dart';
import 'agenda_page.dart';
import 'notifications_page.dart';
import '../../../profile/data/profile_store.dart';

/// Tab Beranda.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _open(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(
                  onBellTap: () => _open(context, const NotificationsPage()),
                ),
                const SizedBox(height: 18),
                                ValueListenableBuilder<String>(
                  valueListenable: ProfileStore.name,
                  builder: (context, name, _) => HomeHeroCard(userName: name),
                ),
                const SizedBox(height: 30),
                SectionHeader(
                  stickerText: 'ACROSS THE BORDER',
                  stickerColor: AppColors.lime,
                  stickerAngle: -2.5,
                  title: 'Agenda pop-up',
                  trailing: UnderlinedLink(
                    label: 'Lihat semua',
                    onTap: () => _open(context, const AgendaPage()),
                  ),
                ),
                const SizedBox(height: 14),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final cardWidth =
                        (constraints.maxWidth * 0.82).clamp(240.0, 340.0);
                    return SizedBox(
                      height: 192,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: HomeMockData.events.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 12),
                        itemBuilder: (context, i) => PopupEventCard(
                          event: HomeMockData.events[i],
                          width: cardWidth.toDouble(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 34),
                const SectionHeader(
                  stickerText: 'THE COMMUNITY EDIT',
                  stickerColor: AppColors.salmon,
                  stickerAngle: -2,
                  title: 'Top GO minggu ini',
                  trailing: Icon(
                    Icons.auto_awesome_outlined,
                    size: 24,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Circle ramai, pengalaman yang berarti.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.body,
                  ),
                ),
                const SizedBox(height: 14),
                for (final group in HomeMockData.topGroups) ...[
                  TopGoCard(
                    group: group,
                    onTap: () => showGoDetailSheet(context, group),
                  ),
                  const SizedBox(height: 12),
                ],
                const SizedBox(height: 2),
                Text(
                  'Peringkat berdasarkan jumlah anggota dan ulasan.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
