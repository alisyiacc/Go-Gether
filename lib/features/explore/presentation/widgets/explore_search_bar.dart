import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

/// Kolom pencarian + tombol buka/tutup filter.
class ExploreSearchBar extends StatelessWidget {
  const ExploreSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.filterOpen,
    required this.onToggleFilter,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool filterOpen;
  final VoidCallback onToggleFilter;

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: color, width: 1.2),
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            textInputAction: TextInputAction.search,
            cursorColor: AppColors.ink,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.ink,
            ),
            decoration: InputDecoration(
              hintText: 'Judul, fandom, atau nama GO',
              hintStyle: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.hint,
              ),
              filled: true,
              fillColor: AppColors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              enabledBorder: _border(AppColors.inputBorder),
              focusedBorder: _border(AppColors.ink),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Tooltip(
          message: 'Filter',
          child: Material(
            color: filterOpen ? AppColors.lime : AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: AppColors.inputBorder, width: 1.2),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onToggleFilter,
              child: const SizedBox(
                width: 50,
                height: 50,
                child: Icon(Icons.tune_rounded, size: 22, color: AppColors.ink),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
