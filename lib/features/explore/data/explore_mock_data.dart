import '../../../core/theme/app_colors.dart';
import '../../home/data/home_mock_data.dart';
import '../../home/domain/go_group.dart';

/// Data contoh halaman Jelajah (mode pratinjau).
class ExploreMockData {
  ExploreMockData._();

  /// Opsi filter. Tambah / ubah pilihan cukup di tiga list ini.
  static const List<String> categories = [
    'Manhwa',
    'Manhua',
    'Manga',
    'Anime',
    'Kpop',
    'Lakorn',
    'Donghua',
    'Novel',
  ];

  static const List<String> countries = [
    'Jepang',
    'Korea',
    'Thailand',
    'Cina',
    'Taiwan',
    'Makau',
    'Filipina',
    'Singapura',
    'Vietnam',
  ];

  /// Semua GO: tiga GO teratas dari Beranda + GO tambahan.
  /// `rank: 0` berarti tidak masuk peringkat Top GO.
  static const List<GoGroup> groups = [
    ...HomeMockData.topGroups,
    GoGroup(
      rank: 0,
      initials: 'SS',
      avatarColor: AppColors.lime,
      name: 'Soul Society GO',
      category: 'Anime',
      country: 'Jepang',
      members: 158,
      rating: 4.7,
      reviews: 61,
      seller: 'Rani A.',
    ),
    GoGroup(
      rank: 0,
      initials: 'PC',
      avatarColor: AppColors.salmon,
      name: 'Pirate Crew Mart',
      category: 'Manga',
      country: 'Jepang',
      members: 142,
      rating: 4.8,
      reviews: 83,
      seller: 'Dimas R.',
    ),
    GoGroup(
      rank: 0,
      initials: 'HB',
      avatarColor: AppColors.lavenderChip,
      name: 'Heaven Bless GO',
      category: 'Manhua',
      country: 'Cina',
      members: 133,
      rating: 4.8,
      reviews: 69,
      seller: 'Lin Y.',
    ),
    GoGroup(
      rank: 0,
      initials: 'WP',
      avatarColor: AppColors.lime,
      name: 'Winter Palette Club',  
      category: 'Manhwa',
      country: 'Korea',
      members: 126,
      rating: 4.6,
      reviews: 48,
      seller: 'Hana L.',
    ),
    GoGroup(
      rank: 0,
      initials: 'JC',
      avatarColor: AppColors.salmon,
      name: 'Jinx Corner',
      category: 'Manhwa',
      country: 'Korea',
      members: 117,
      rating: 4.7,
      reviews: 52,
      seller: 'Mira T.',
    ),
    GoGroup(
      rank: 0,
      initials: 'DD',
      avatarColor: AppColors.lavenderChip,
      name: 'GO LEZHIN DD',
      category: 'Manhwa',
      country: 'Korea',
      members: 96,
      rating: 4.5,
      reviews: 31,
      seller: 'Sinta W.',
    ),
    GoGroup(
      rank: 0,
      initials: 'SP',
      avatarColor: AppColors.lime,
      name: 'Stage Pass Seoul',
      category: 'Kpop',
      country: 'Korea',
      members: 164,
      rating: 4.7,
      reviews: 72,
      seller: 'Yuna K.',
    ),
  ];
}
