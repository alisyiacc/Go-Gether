import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/sticker.dart';
import '../../../home/domain/go_group.dart';
import '../../../home/presentation/widgets/go_detail_sheet.dart';
import '../../data/explore_mock_data.dart';
import '../widgets/explore_filter_panel.dart';
import '../widgets/explore_go_card.dart';
import '../widgets/explore_search_bar.dart';

/// Tab Jelajah: cari GO lewat kata kunci dan filter.
class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  static const String _all = 'Semua';

  final TextEditingController _searchController = TextEditingController();
  bool _filterOpen = false;
  String _category = _all;
  String _country = _all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<GoGroup> get _results {
    final query = _searchController.text.trim().toLowerCase();
    return ExploreMockData.groups.where((g) {
      if (_category != _all && g.category != _category) return false;
      if (_country != _all && g.country != _country) return false;
      if (query.isNotEmpty &&
          !g.name.toLowerCase().contains(query) &&
          !g.series.toLowerCase().contains(query)) {
        return false;
      }
      return true;
    }).toList();
  }

  void _resetFilters() {
    setState(() {
      _category = _all;
      _country = _all;
    });
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 2),
                  child: Sticker(
                    text: 'FIND YOUR CIRCLE',
                    color: AppColors.lime,
                    angleDegrees: -3,
                    fontSize: 10,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Ketemu GO yang pas.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.9,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 16),
                ExploreSearchBar(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  filterOpen: _filterOpen,
                  onToggleFilter: () =>
                      setState(() => _filterOpen = !_filterOpen),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  alignment: Alignment.topCenter,
                  child: _filterOpen
                      ? Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: ExploreFilterPanel(
                            allLabel: _all,
                            categories: ExploreMockData.categories,
                            countries: ExploreMockData.countries,
                            category: _category,
                            country: _country,
                            onCategoryChanged: (v) =>
                                setState(() => _category = v),
                            onCountryChanged: (v) =>
                                setState(() => _country = v),
                            onReset: _resetFilters,
                          ),
                        )
                      : const SizedBox(width: double.infinity),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${results.length} GO ditemukan',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                      ),
                    ),
                    Text(
                      'Pilihan komunitas',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                if (results.isEmpty)
                  const _EmptyResults()
                else
                  for (final group in results) ...[
                    ExploreGoCard(
                      group: group,
                      onTap: () => showGoDetailSheet(context, group),
                    ),
                    const SizedBox(height: 12),
                  ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyResults extends StatelessWidget {
  const _EmptyResults();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: AppColors.hint.withValues(alpha: 0.55),
        fill: Colors.transparent,
        radius: 16,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Text(
          'Belum ada GO yang cocok. Coba judul lain atau reset filter.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.5,
            height: 1.5,
            fontWeight: FontWeight.w500,
            color: AppColors.body,
          ),
        ),
      ),
    );
  }
}
