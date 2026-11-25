import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

/// Panel filter lavender: Kategori, Fandom, Negara + tombol reset.
class ExploreFilterPanel extends StatelessWidget {
  const ExploreFilterPanel({
    super.key,
    required this.allLabel,
    required this.categories,
    required this.countries,
    required this.category,
    required this.country,
    required this.onCategoryChanged,
    required this.onCountryChanged,
    required this.onReset,
  });

  final String allLabel;
  final List<String> categories;
  final List<String> countries;
  final String category;
  final String country;
  final ValueChanged<String> onCategoryChanged;
  final ValueChanged<String> onCountryChanged;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: AppColors.lavenderSoft,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.ink.withValues(alpha: 0.7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterDropdown(
            label: 'Kategori',
            value: category,
            items: [allLabel, ...categories],
            onChanged: onCategoryChanged,
          ),
          const SizedBox(height: 14),
          FilterDropdown(
            label: 'Negara',
            value: country,
            items: [allLabel, ...countries],
            onChanged: onCountryChanged,
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
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
                onTap: onReset,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Center(
                    child: Text(
                      'Reset filter',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Dropdown berlabel. Border berubah ungu saat sedang fokus / terbuka.
class FilterDropdown extends StatefulWidget {
  const FilterDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  @override
  State<FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  late final FocusNode _focus;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focus = FocusNode()
      ..addListener(() {
        if (mounted) setState(() => _focused = _focus.hasFocus);
      });
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.plusJakartaSans(
      fontSize: 13.5,
      fontWeight: FontWeight.w700,
      color: AppColors.ink,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: AppColors.ink,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _focused ? AppColors.purple : AppColors.inputBorder,
              width: _focused ? 1.8 : 1.2,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              focusNode: _focus,
              value: widget.value,
              isExpanded: true,
              borderRadius: BorderRadius.circular(14),
              dropdownColor: AppColors.white,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.ink,
              ),
              style: textStyle,
              items: [
                for (final item in widget.items)
                  DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, style: textStyle),
                  ),
              ],
              onChanged: (v) {
                if (v != null) widget.onChanged(v);
              },
            ),
          ),
        ),
      ],
    );
  }
}
