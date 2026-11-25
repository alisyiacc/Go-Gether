import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/dark_button.dart';
import '../../../../shared/widgets/icon_square_button.dart';
import '../../../../shared/widgets/sticker.dart';
import '../../data/seller_options.dart';
import '../../data/seller_status_store.dart';
import 'multi_choice_chips.dart';

/// Bottom sheet pendaftaran calon seller (3 langkah: data diri, foto KTP,
/// selesai). Semua data hanya di memori dan tidak dikirim ke mana pun.
Future<void> showSellerRegistrationSheet(BuildContext context) {
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
    builder: (_) => const _SellerRegistrationSheet(),
  );
}

class _SellerRegistrationSheet extends StatefulWidget {
  const _SellerRegistrationSheet();

  @override
  State<_SellerRegistrationSheet> createState() =>
      _SellerRegistrationSheetState();
}

class _SellerRegistrationSheetState extends State<_SellerRegistrationSheet> {
  int _step = 1;

  final TextEditingController _nameController = TextEditingController();
  DateTime? _birthDate;
  final Set<String> _categories = <String>{};
  final Set<String> _countries = <String>{};

  Uint8List? _ktpBytes;
  String? _ktpName;
  String? _pickError;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // ---------- validasi ----------

  int _ageOf(DateTime birth) {
    final now = DateTime.now();
    int age = now.year - birth.year;
    if (now.month < birth.month ||
        (now.month == birth.month && now.day < birth.day)) {
      age--;
    }
    return age;
  }

  bool get _isAdult =>
      _birthDate != null && _ageOf(_birthDate!) >= SellerOptions.minAge;

  bool get _underAge =>
      _birthDate != null && _ageOf(_birthDate!) < SellerOptions.minAge;

  bool get _step1Valid =>
      _nameController.text.trim().isNotEmpty &&
      _isAdult &&
      _categories.isNotEmpty &&
      _countries.isNotEmpty;

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/'
      '${d.month.toString().padLeft(2, '0')}/${d.year}';

  // ---------- aksi ----------

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(now.year - 20, 1, 1),
      firstDate: DateTime(1920),
      lastDate: now,
      helpText: 'Tanggal lahir sesuai KTP',
    );
    if (picked != null && mounted) setState(() => _birthDate = picked);
  }

  Future<void> _pickKtpFromGallery() async {
    try {
      final XFile? file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1600,
        imageQuality: 85,
      );
      if (file == null) return;
      final bytes = await file.readAsBytes();
      if (!mounted) return;
      setState(() {
        _ktpBytes = bytes;
        _ktpName = file.name;
        _pickError = null;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _pickError = 'Tidak bisa membuka galeri. Coba lagi.');
    }
  }

  void _toggle(Set<String> set, String value) {
    setState(() {
      if (!set.remove(value)) set.add(value);
    });
  }

  // ---------- UI ----------

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 100),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Daftar calon seller',
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
            const SizedBox(height: 16),
            if (_step == 1) ..._stepOne(),
            if (_step == 2) ..._stepTwo(),
            if (_step == 3) ..._stepThree(),
          ],
        ),
      ),
    );
  }

  TextStyle get _labelStyle => GoogleFonts.plusJakartaSans(
        fontSize: 13.5,
        fontWeight: FontWeight.w800,
        color: AppColors.ink,
      );

  TextStyle get _descStyle => GoogleFonts.plusJakartaSans(
        fontSize: 13.5,
        height: 1.5,
        fontWeight: FontWeight.w500,
        color: AppColors.body,
      );

  TextStyle get _helperStyle => GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.muted,
      );

  Widget _stepSticker(String text) => Sticker(
        text: text,
        color: AppColors.lime,
        angleDegrees: -2,
        fontSize: 10,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      );

  OutlineInputBorder _border(Color c) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: c, width: 1.2),
      );

  // ----- Langkah 1 -----
  List<Widget> _stepOne() {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 2),
        child: _stepSticker('LANGKAH 1 / 2'),
      ),
      const SizedBox(height: 14),
      Text(
        'Ceritakan rencana GO-mu. Nama dan tanggal lahir harus sesuai KTP.',
        style: _descStyle,
      ),
      const SizedBox(height: 18),
      Text('Nama lengkap sesuai KTP', style: _labelStyle),
      const SizedBox(height: 8),
      TextField(
        controller: _nameController,
        onChanged: (_) => setState(() {}),
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.done,
        cursorColor: AppColors.ink,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 14.5,
          fontWeight: FontWeight.w500,
          color: AppColors.ink,
        ),
        decoration: InputDecoration(
          hintText: 'Nama lengkap',
          hintStyle: GoogleFonts.plusJakartaSans(
            fontSize: 14.5,
            fontWeight: FontWeight.w500,
            color: AppColors.hint,
          ),
          filled: true,
          fillColor: AppColors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          enabledBorder: _border(AppColors.inputBorder),
          focusedBorder: _border(AppColors.ink),
        ),
      ),
      const SizedBox(height: 16),
      Text('Tanggal lahir sesuai KTP', style: _labelStyle),
      const SizedBox(height: 8),
      Material(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: _underAge ? AppColors.alert : AppColors.inputBorder,
            width: 1.2,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _pickBirthDate,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _birthDate == null ? 'dd/mm/yyyy' : _formatDate(_birthDate!),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w500,
                      color: _birthDate == null
                          ? AppColors.hint
                          : AppColors.ink,
                    ),
                  ),
                ),
                const Icon(Icons.calendar_today_outlined,
                    size: 18, color: AppColors.ink),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 6),
      Text(
        _underAge
            ? 'Usia belum cukup. Calon seller minimal berusia '
                '${SellerOptions.minAge} tahun.'
            : 'Calon seller minimal berusia ${SellerOptions.minAge} tahun.',
        style: _helperStyle.copyWith(
          color: _underAge ? AppColors.alert : AppColors.muted,
        ),
      ),
      const SizedBox(height: 16),
      Text('Kategori GO', style: _labelStyle),
      const SizedBox(height: 4),
      Text('Boleh pilih lebih dari satu.', style: _helperStyle),
      const SizedBox(height: 10),
      MultiChoiceChips(
        options: SellerOptions.categories,
        selected: _categories,
        onToggle: (v) => _toggle(_categories, v),
      ),
      const SizedBox(height: 16),
      Text('Negara asal merch', style: _labelStyle),
      const SizedBox(height: 4),
      Text('Boleh pilih lebih dari satu.', style: _helperStyle),
      const SizedBox(height: 10),
      MultiChoiceChips(
        options: SellerOptions.countries,
        selected: _countries,
        onToggle: (v) => _toggle(_countries, v),
      ),
      const SizedBox(height: 20),
           DarkButton(
        label: 'Lanjut foto KTP',
        onPressed: _step1Valid ? () => setState(() => _step = 2) : null,
      ),
    ];
  }

  // ----- Langkah 2 -----
  List<Widget> _stepTwo() {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 2),
        child: _stepSticker('LANGKAH 2 / 2'),
      ),
      const SizedBox(height: 14),
      Text(
                'Unggah foto KTP-mu dari galeri. Semua sudut kartu harus terlihat.',
        style: _descStyle,
      ),
      const SizedBox(height: 16),
      GestureDetector(
        onTap: _pickKtpFromGallery,
        child: CustomPaint(
          painter: DashedBorderPainter(
            color: AppColors.purple.withValues(alpha: 0.55),
            fill: AppColors.lavender,
            radius: 16,
          ),
          child: SizedBox(
            width: double.infinity,
            height: 140,
            child: _ktpBytes == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.photo_camera_outlined,
                          size: 26, color: AppColors.ink),
                      const SizedBox(height: 12),
                      Text(
                        'Pilih foto KTP dari galeri',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        _ktpBytes!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
          ),
        ),
      ),
      if (_ktpBytes != null) ...[
        const SizedBox(height: 8),
        Text(
          '${_ktpName ?? 'foto'} · ketuk gambar untuk mengganti',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: _helperStyle,
        ),
      ],
      if (_pickError != null) ...[
        const SizedBox(height: 8),
        Text(_pickError!, style: _helperStyle.copyWith(color: AppColors.alert)),
      ],
      const SizedBox(height: 16),
            DarkButton(
        label: 'Kirim foto KTP',
        showArrow: false,
        onPressed: _ktpBytes != null
            ? () {
                SellerStatusStore.markRegistered();
                setState(() => _step = 3);
              }
            : null,
      ),
    ];
  }

  // ----- Langkah 3 -----
  List<Widget> _stepThree() {
    return [
      const SizedBox(height: 8),
      Center(
        child: Container(
          width: 56,
          height: 56,
          decoration: const BoxDecoration(
            color: AppColors.lime,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_rounded,
              size: 28, color: AppColors.ink),
        ),
      ),
      const SizedBox(height: 14),
      Center(
        child: Text(
          'Completed',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: AppColors.ink,
          ),
        ),
      ),
      const SizedBox(height: 10),
      Text(
        'Foto dan data KTP telah disimpan.',
        textAlign: TextAlign.center,
        style: _descStyle,
      ),
      const SizedBox(height: 18),
      DarkButton(
        label: 'Selesai',
        showArrow: false,
        onPressed: () => Navigator.of(context).pop(),
      ),
    ];
  }
}
