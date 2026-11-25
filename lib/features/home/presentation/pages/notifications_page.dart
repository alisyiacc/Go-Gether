import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_bottom_nav.dart';
import '../../../../shared/widgets/page_header.dart';
import '../../../../shared/widgets/sticker.dart';
import '../../../shell/presentation/main_shell.dart';

class _SystemNotice {
  const _SystemNotice(this.label, this.title, this.body);
  final String label;
  final String title;
  final String body;
}

/// Halaman "Kabar dari GOGether" berisi notifikasi sistem contoh.
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  static const List<_SystemNotice> _notices = [
    _SystemNotice(
      'Info sistem · 1',
      'Selamat datang di GOGether',
      'Kenali seller melalui ringkasan GO sebelum memutuskan bergabung.',
    ),
    _SystemNotice(
      'Info sistem · 2',
      'Jaga informasi pribadimu',
      'Sebelum mengirim bukti transfer ke grup, tutupi nomor rekening dan '
          'data sensitif yang tidak diperlukan.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                  const PageHeader(title: 'Kabar dari GOGether'),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.only(left: 2),
                    child: Sticker(
                      text: 'SYSTEM UPDATES',
                      color: AppColors.lime,
                      angleDegrees: -2,
                      fontSize: 10,
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    ),
                  ),
                  const SizedBox(height: 14),
                  for (final n in _notices) ...[
                    _NoticeCard(notice: n),
                    const SizedBox(height: 12),
                  ],
                  const SizedBox(height: 2),
                  Text(
                    'Info penting',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.body,
                    ),
                  ),
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

class _NoticeCard extends StatelessWidget {
  const _NoticeCard({required this.notice});

  final _SystemNotice notice;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.inputBorder, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.notifications_none_rounded,
                  size: 16, color: AppColors.ink),
              const SizedBox(width: 8),
              Text(
                notice.label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.body,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            notice.title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15.5,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            notice.body,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.5,
              height: 1.5,
              fontWeight: FontWeight.w500,
              color: AppColors.body,
            ),
          ),
        ],
      ),
    );
  }
}
