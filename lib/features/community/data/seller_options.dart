/// Pilihan pada formulir pendaftaran calon seller.
/// Tambah / ubah pilihan cukup di dua list ini.
class SellerOptions {
  SellerOptions._();

  static const List<String> categories = [
    'Manhwa',
    'Manhua',
    'Manga',
    'Anime',
    'Lakorn',
    'Donghua'
    'Novel',
  ];

  static const List<String> countries = [
    'Jepang',
    'Korea',
    'Thailand',
    'Cina'
    'Taiwan'
    'Makau'
    'Filipina'
    'Singapura'
    'Vietnam',
  ];

  /// Usia minimal calon seller.
  static const int minAge = 18;
}
