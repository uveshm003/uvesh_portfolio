import 'package:flutter/material.dart';

/// Color tokens for the portfolio.
///
/// The identity is "instrument": a precision-engineering surface rather than a
/// warm editorial page. The palette is cool and architectural — a faintly green
/// off-white ground, near-black ink with a blue undertone, and a single
/// confident cobalt signal that reads like a calibrated indicator. Surfaces sit
/// a hair off the ground so panels feel like machined plates, not soft cards.
class AppColors {
  const AppColors._();

  // ---- Light theme ----------------------------------------------------------
  static const Color lightBackground = Color(0xFFF4F5F3); // cool architectural paper
  static const Color lightSurface = Color(0xFFFBFCFB); // raised plate, a hair lighter
  static const Color lightTextPrimary = Color(0xFF15171C); // cool near-black ink
  static const Color lightTextSecondary = Color(0xFF565B66); // muted prose
  static const Color lightTextFaint = Color(0xFF9498A2); // dates / captions
  static const Color lightAccent = Color(0xFF2E47D6); // cobalt signal
  static const Color lightAccentHover = Color(0xFF2238B8);
  static const Color lightAccentSoft = Color(0x142E47D6); // ~8% cobalt wash
  // The cobalt already clears AA on the paper ground (~6:1), so links can track
  // the accent directly; a touch deeper keeps it crisp at body size.
  static const Color lightLink = Color(0xFF2A41C7);
  static const Color lightLinkHover = Color(0xFF1B2F9E);
  static const Color lightDivider = Color(0xFFE2E4E0); // cool hairline

  // ---- Dark theme -----------------------------------------------------------
  static const Color darkBackground = Color(0xFF121317); // graphite
  static const Color darkSurface = Color(0xFF1B1D23); // raised plate
  static const Color darkTextPrimary = Color(0xFFECEDEF);
  static const Color darkTextSecondary = Color(0xFF9A9EA8);
  static const Color darkTextFaint = Color(0xFF6B6F79);
  static const Color darkAccent = Color(0xFF6E83FF); // cobalt, lifted for graphite
  static const Color darkAccentHover = Color(0xFF8A9BFF);
  static const Color darkAccentSoft = Color(0x1F6E83FF); // ~12% cobalt wash
  static const Color darkLink = Color(0xFF8A9BFF);
  static const Color darkLinkHover = Color(0xFFA8B5FF);
  static const Color darkDivider = Color(0xFF2A2D35);
}
