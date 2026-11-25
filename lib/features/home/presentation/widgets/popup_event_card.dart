import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/popup_event.dart';
import 'neon_art.dart';

/// Kartu agenda pop-up dengan latar gambar, chip lokasi, judul, dan tanggal.
class PopupEventCard extends StatelessWidget {
  const PopupEventCard({
    super.key,
    required this.event,
    this.width,
    this.showDivider = false,
  });

  final PopupEvent event;
  final double? width;

  /// Garis tipis di atas tanggal (dipakai di halaman Agenda).
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final overlay = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0.0, 0.5, 1.0],
      colors: [
        AppColors.ink.withValues(alpha: 0.15),
        AppColors.ink.withValues(alpha: 0.35),
        AppColors.ink.withValues(alpha: 0.9),
      ],
    );

    return SizedBox(
      width: width,
      height: 192,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.ink, width: 1.2),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (event.image != null)
                Image(image: event.image!, fit: BoxFit.cover)
              else
                NeonCityArt(seed: event.artSeed, lanterns: event.lanterns),
              DecoratedBox(decoration: BoxDecoration(gradient: overlay)),
              Positioned(
                left: 12,
                top: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: event.chipColor,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: AppColors.ink, width: 1),
                  ),
                  child: Text(
                    '${event.city} / ${event.country}',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 14,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.category,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.3,
                        color: Colors.white.withValues(alpha: 0.78),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      event.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        color: Colors.white,
                      ),
                    ),
                    if (showDivider)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        child: Container(
                          height: 1,
                          color: Colors.white.withValues(alpha: 0.28),
                        ),
                      )
                    else
                      const SizedBox(height: 10),
                    Text(
                      event.dateLabel,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
