import 'package:flutter/material.dart';

/// Grup GO (Group Order) yang dikelola seorang seller.
class GoGroup {
  const GoGroup({
    required this.rank,
    required this.initials,
    required this.avatarColor,
    required this.name,
    required this.series,
    required this.category,
    required this.country,
    required this.members,
    required this.rating,
    required this.reviews,
    required this.seller,
    this.image,
  });

  final int rank;
  final String initials;
  final Color avatarColor;
  final String name;
  final String series;
  final String category;
  final String country;
  final int members;
  final double rating;
  final int reviews;
  final String seller;

  /// Foto banner di detail GO. Kosong = ilustrasi bawaan.
  final ImageProvider? image;

  String get description =>
      'Grup untuk berbagi info dan mengikuti GO $series. Diskusikan detail '
      'barang, biaya, dan pembayaran langsung dengan admin. Kamu bebas '
      'memutuskan sebelum bergabung.';
}
