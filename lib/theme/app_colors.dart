import 'package:flutter/material.dart';

/// Color tokens for the portfolio.
///
/// We avoid pure black / pure white in favour of soft off-shades so the page
/// reads as calm prose rather than a harsh high-contrast UI. A single
/// understated accent is used for links and hover states.
class AppColors {
  const AppColors._();

  // ---- Light theme ----------------------------------------------------------
  static const Color lightBackground = Color(0xFFFBFAF7); // warm near-white
  static const Color lightSurface = Color(0xFFF3F1EC); // subtle raised tint
  static const Color lightTextPrimary = Color(0xFF1F1E1B); // near-black, warm
  static const Color lightTextSecondary = Color(0xFF6E6A62); // muted prose
  static const Color lightTextFaint = Color(0xFF9A958B); // dates / captions
  static const Color lightAccent = Color(0xFF3D6B8C); // calm slate-blue link
  static const Color lightAccentHover = Color(0xFF2C5573);
  static const Color lightDivider = Color(0xFFE4E1DA);

  // ---- Dark theme -----------------------------------------------------------
  static const Color darkBackground = Color(0xFF16150F); // warm near-black
  static const Color darkSurface = Color(0xFF20201A);
  static const Color darkTextPrimary = Color(0xFFEDEAE2);
  static const Color darkTextSecondary = Color(0xFFA8A398);
  static const Color darkTextFaint = Color(0xFF7C776C);
  static const Color darkAccent = Color(0xFF82AAC9);
  static const Color darkAccentHover = Color(0xFFA6C5DC);
  static const Color darkDivider = Color(0xFF2E2D26);
}
