import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/icon_square_button.dart';
import '../../data/profile_store.dart';

/// Teks "Tentang & privasi". Pastikan isinya sesuai kebijakan privasi
/// dan cara kerja aplikasi yang sebenarnya.
const String kAboutPrivacyText =
    'GOGether adalah aplikasi yang mempertemukan buyer dan seller '
    'GO. GOGether bukan platform checkout: harga, pembayaran, dan pengiriman '
    'disepakati langsung antara kamu dan seller, sehingga kesepakatan itu '
    'berada di luar tanggung jawab GOGether.\n\n'
    'Kenali seller lewat rating dan ulasan, tanyakan detail barang sebelum '
    'membayar, dan hentikan transaksi bila ada yang terasa janggal.\n\n'
    'Data KTP calon seller hanya dipakai untuk pengecekan identitas dan '
    'tidak ditampilkan ke pengguna lain.';

/// Pop-up "Pengaturan akun".
Future<void> showSettingsSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.background,
    constraints: const BoxConstraints(maxWidth: 520),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      side: BorderSide(color: AppColors.ink, width: 1.2),
    ),
    builder: (_) => const _SettingsSheet(),
  );
}

class _SettingsSheet extends StatefulWidget {
  const _SettingsSheet();

  @override
  State<_SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<_SettingsSheet> {
  late final TextEditingController _nameController;
  bool _saved = false;
  bool _aboutOpen = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: ProfileStore.name.value);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveName() {
    ProfileStore.setName(_nameController.text);
    FocusScope.of(context).unfocus();
    setState(() => _saved = true);
  }

  void _logout() {
    final nav = Navigator.of(context);
    nav.pop();
    nav.pushNamedAndRemoveUntil('/sign-in', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 100),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Pengaturan akun',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.4,
                      color: AppColors.ink,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconSquareButton(
                  icon: Icons.close_rounded,
                  tooltip: 'Tutup',
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              'Nama panggilan',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              onChanged: (_) {
                if (_saved) setState(() => _saved = false);
              },
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _saveName(),
              cursorColor: AppColors.ink,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: AppColors.inputBorder,
                    width: 1.2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide:
                      const BorderSide(color: AppColors.ink, width: 1.2),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Material(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(
                    color: AppColors.inputBorder,
                    width: 1.2,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: _saveName,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 13,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_saved) ...[
                          const Icon(Icons.check_rounded,
                              size: 16, color: AppColors.ink),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          _saved ? 'Tersimpan' : 'Simpan nama',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            const _NotificationCard(),
            const SizedBox(height: 12),
            _OutlinedRowButton(
              onTap: () => setState(() => _aboutOpen = !_aboutOpen),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tentang & privasi',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(width: 6),
                  AnimatedRotation(
                    turns: _aboutOpen ? 0.5 : 0,
                    duration: const Duration(milliseconds: 180),
                    child: const Icon(Icons.keyboard_arrow_down_rounded,
                        size: 20, color: AppColors.ink),
                  ),
                ],
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              alignment: Alignment.topCenter,
              child: _aboutOpen
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(4, 12, 4, 0),
                      child: Text(
                        kAboutPrivacyText,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          height: 1.55,
                          fontWeight: FontWeight.w500,
                          color: AppColors.body,
                        ),
                      ),
                    )
                  : const SizedBox(width: double.infinity),
            ),
            const SizedBox(height: 14),
            _OutlinedRowButton(
              borderColor: const Color(0xFFE8C3BB),
              onTap: _logout,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.logout_rounded,
                      size: 17, color: Color(0xFFB3412F)),
                  const SizedBox(width: 8),
                  Text(
                    'Keluar ke sign in',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFB3412F),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OutlinedRowButton extends StatelessWidget {
  const _OutlinedRowButton({
    required this.child,
    required this.onTap,
    this.borderColor = AppColors.inputBorder,
  });

  final Widget child;
  final VoidCallback onTap;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: borderColor, width: 1.2),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ProfileStore.notificationsEnabled,
      builder: (context, enabled, _) {
        return Material(
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.inputBorder, width: 1.2),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => ProfileStore.notificationsEnabled.value = !enabled,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notifikasi sistem',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Info penting seputar GO dan akunmu',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color:
                          enabled ? AppColors.lime : AppColors.lavenderSoft,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      enabled ? 'Aktif' : 'Nonaktif',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: enabled ? AppColors.ink : AppColors.body,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
