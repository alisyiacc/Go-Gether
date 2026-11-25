import 'package:flutter/material.dart';

/// Agenda pop-up store / event di luar negeri.
class PopupEvent {
  const PopupEvent({
    required this.city,
    required this.country,
    required this.category,
    required this.title,
    required this.dateLabel,
    required this.chipColor,
    required this.artSeed,
    this.lanterns = false,
    this.image,
  });

  final String city;
  final String country;
  final String category;
  final String title;
  final String dateLabel;
  final Color chipColor;

  /// Seed untuk ilustrasi latar bawaan (dipakai bila [image] kosong).
  final int artSeed;
  final bool lanterns;

  /// Foto latar kartu. Isi dengan `AssetImage('assets/...')` bila punya foto.
  final ImageProvider? image;
}
