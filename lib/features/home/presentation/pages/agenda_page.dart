import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_bottom_nav.dart';
import '../../../../shared/widgets/page_header.dart';
import '../../../shell/presentation/main_shell.dart';
import '../../data/home_mock_data.dart';
import '../../domain/popup_event.dart';
import '../widgets/popup_event_card.dart';

/// Halaman daftar agenda pop-up dengan filter negara.
class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  static const String _all = 'Semua';
  String _country = _all;

  List<String> get _countries => [
        _all,
         'Jepang',
        'Korea',
        'Thailand',
        'China',
      ];

  List<PopupEvent> get _filtered => _country == _all
      ? HomeMockData.events
      : HomeMockData.events.where((e) => e.country == _country).toList();

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.plusJakartaSans(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: AppColors.ink,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PageHeader(title: 'Agenda pop-up'),
                  const SizedBox(height: 18),
                  Text(
                    'Dari luar negeri, buat wishlist kamu. Informasi event di '
                    'pratinjau merupakan contoh.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                      color: AppColors.body,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text('Negara event', style: textStyle),
                  const SizedBox(height: 8),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.inputBorder,
                        width: 1.2,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _country,
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(16),
                        dropdownColor: AppColors.white,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.ink,
                        ),
                        style: textStyle,
                        items: [
                          for (final c in _countries)
                            DropdownMenuItem<String>(
                              value: c,
                              child: Text(c, style: textStyle),
                            ),
                        ],
                        onChanged: (v) {
                          if (v != null) setState(() => _country = v);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                                    if (_filtered.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: Text(
                          'Belum ada agenda untuk negara ini.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: AppColors.muted,
                          ),
                        ),
                      ),
                    ),
                  for (final event in _filtered) ...[
                    PopupEventCard(event: event, showDivider: true),
                    const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: null,
        onTap: (i) {
          mainTabIndex.value = i;
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }
}
