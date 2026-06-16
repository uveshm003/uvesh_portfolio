import 'package:flutter/material.dart';

/// Color tokens for the portfolio.
///
/// The palette is deliberately light and low-contrast: warm paper backgrounds,
/// softened (never pure-black) ink, and a single warm clay accent that reads as
/// calm and editorial rather than a harsh high-contrast UI. Surfaces sit only a
/// hair above the page so cards feel like raised paper, not boxes.
class AppColors {
  const AppColors._();

  // ---- Light theme ----------------------------------------------------------
  static const Color lightBackground = Color(0xFFFCFBF8); // light warm paper
  static const Color lightSurface = Color(0xFFF6F2EA); // soft raised card fill
  static const Color lightTextPrimary = Color(0xFF2E2A24); // softened warm ink
  static const Color lightTextSecondary = Color(0xFF6F6A60); // muted prose
  static const Color lightTextFaint = Color(0xFFA9A498); // dates / captions
  static const Color lightAccent = Color(0xFFB06B4F); // warm muted clay
  static const Color lightAccentHover = Color(0xFF96573D);
  static const Color lightAccentSoft = Color(0x14B06B4F); // 8% clay tint wash
  // Deeper clay for body-size text links so they clear AA contrast while the
  // brighter [lightAccent] stays for graphical marks (rules, dots, underlines).
  static const Color lightLink = Color(0xFF985539); // ~5.5:1 on paper
  static const Color lightLinkHover = Color(0xFF7C4329);
  static const Color lightDivider = Color(0xFFEBE6DC);

  // ---- Dark theme -----------------------------------------------------------
  static const Color darkBackground = Color(0xFF1A1813); // warm near-black
  static const Color darkSurface = Color(0xFF252118); // raised card fill
  static const Color darkTextPrimary = Color(0xFFEDE9E0);
  static const Color darkTextSecondary = Color(0xFFA9A398);
  static const Color darkTextFaint = Color(0xFF7B766B);
  static const Color darkAccent = Color(0xFFD8967A); // warm clay, lifted
  static const Color darkAccentHover = Color(0xFFE7AE94);
  static const Color darkAccentSoft = Color(0x1FD8967A); // ~12% clay tint wash
  // On dark the lifted clay is already very readable; links track it and
  // brighten on hover.
  static const Color darkLink = Color(0xFFD8967A);
  static const Color darkLinkHover = Color(0xFFE7AE94);
  static const Color darkDivider = Color(0xFF312D24);
}
