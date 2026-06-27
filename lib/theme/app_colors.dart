import 'package:flutter/material.dart';

/// Color tokens for the portfolio.
///
/// The identity is "warm editorial": a thoughtful person's own page, not a SaaS
/// dashboard. The ground is a warm cream paper, the ink a soft brown-black, and
/// the single signal is a deep botanical green — fountain-pen ink, a library
/// spine — calm and bookish rather than a notification badge. Surfaces sit a
/// hair warmer than the ground so panels feel like a second sheet on the desk.
class AppColors {
  const AppColors._();

  // ---- Light theme ----------------------------------------------------------
  static const Color lightBackground = Color(0xFFFBF7EF); // warm cream paper
  static const Color lightSurface = Color(0xFFFFFDF8); // a second, lighter sheet
  static const Color lightTextPrimary = Color(0xFF2A2521); // warm near-black ink
  static const Color lightTextSecondary = Color(0xFF6B5F54); // warm muted prose
  static const Color lightTextFaint = Color(0xFF9C9085); // dates / captions
  static const Color lightAccent = Color(0xFF2F6E4E); // deep botanical green signal
  static const Color lightAccentHover = Color(0xFF275C41);
  static const Color lightAccentSoft = Color(0x162F6E4E); // ~9% green wash
  // Links run a touch deeper than the graphical accent so body-size text clears
  // AA on the cream ground while accent marks can stay bright.
  static const Color lightLink = Color(0xFF2C6347);
  static const Color lightLinkHover = Color(0xFF1F4A33);
  static const Color lightDivider = Color(0xFFE9DFCF); // warm hairline

  // ---- Dark theme -----------------------------------------------------------
  static const Color darkBackground = Color(0xFF211C18); // warm charcoal-brown
  static const Color darkSurface = Color(0xFF2A2420); // raised sheet
  static const Color darkTextPrimary = Color(0xFFECE3D6); // warm cream text
  static const Color darkTextSecondary = Color(0xFFA89A8B);
  static const Color darkTextFaint = Color(0xFF7C6F61);
  static const Color darkAccent = Color(0xFF6FBE91); // sage green, lifted for the dark ground
  static const Color darkAccentHover = Color(0xFF84CBA2);
  static const Color darkAccentSoft = Color(0x246FBE91); // ~14% green wash
  static const Color darkLink = Color(0xFF82C6A0);
  static const Color darkLinkHover = Color(0xFF9BD4B5);
  static const Color darkDivider = Color(0xFF3A322B); // warm hairline
}
