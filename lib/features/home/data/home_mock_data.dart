import '../../../core/theme/app_colors.dart';
import '../domain/go_group.dart';
import '../domain/popup_event.dart';

/// Data contoh untuk mode pratinjau.
class HomeMockData {
  HomeMockData._();

  static const String userName = 'Caca';

  static const List<PopupEvent> events = [
    PopupEvent(
      city: 'TOKYO',
      country: 'Jepang',
      category: 'POP-UP STORE',
      title: 'JJK Hidden Inventory',
      dateLabel: '12–28 Juni 2026',
      chipColor: AppColors.lime,
      artSeed: 3,
    ),
    PopupEvent(
      city: 'OSAKA',
      country: 'Jepang',
      category: 'ONE PIECE COLLECTION',
      title: 'Mugiwara Store',
      dateLabel: 'Coming soon',
      chipColor: AppColors.salmon,
      artSeed: 7,
      lanterns: true,
    ),
    PopupEvent(
      city: 'SEOUL',
      country: 'Korea',
      category: 'MERCH & EXHIBITION',
      title: 'Webtoon Collectives',
      dateLabel: '3–12 Juli 2026',
      chipColor: AppColors.lavenderChip,
      artSeed: 3,
    ),
    PopupEvent(
      city: 'BANGKOK',
      country: 'Thailand',
      category: 'SPECIAL POP-UP',
      title: 'Fandom Weekend',
      dateLabel: 'Coming soon',
      chipColor: AppColors.lime,
      artSeed: 7,
      lanterns: true,
    ),
  ];

  static const List<GoGroup> topGroups = [
    GoGroup(
      rank: 1,
      initials: 'MP',
      avatarColor: AppColors.lime,
      name: 'MochiGO Japan',
      series: 'Jujutsu Kaisen',
      category: 'Anime',
      country: 'Jepang',
      members: 284,
      rating: 4.9,
      reviews: 128,
      seller: 'Nadine P.',
    ),
    GoGroup(
      rank: 2,
      initials: 'AK',
      avatarColor: AppColors.salmon,
      name: 'Seoul Cart Club',
      series: 'Solo Leveling',
      category: 'Manhwa',
      country: 'Korea',
      members: 219,
      rating: 4.8,
      reviews: 94,
      seller: 'Jiwon K.',
    ),
    GoGroup(
      rank: 3,
      initials: 'MA',
      avatarColor: AppColors.lavenderChip,
      name: 'Bangkok Buddy',
      series: 'GMMTV',
      category: 'Series',
      country: 'Thailand',
      members: 173,
      rating: 4.9,
      reviews: 77,
      seller: 'Ploy S.',
    ),
  ];
}
