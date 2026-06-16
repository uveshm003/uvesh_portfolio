import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography tokens.
///
/// Type does the heavy lifting on this site, so the pairing is deliberate:
///   • Headings / name  -> Fraunces (a refined, slightly literary serif)
///   • Body / nav / tags -> Inter (a highly readable neutral sans)
///
/// All sizes live here as a clear scale; widgets reference the resulting
/// [TextTheme] or the named helper styles rather than inventing their own.
class AppTypography {
  const AppTypography._();

  static const double _bodyHeight = 1.7;

  /// Builds the Material [TextTheme] for a given foreground color.
  static TextTheme textTheme(Color primary) {
    final serif = GoogleFonts.fraunces;
    final sans = GoogleFonts.inter;

    return TextTheme(
      // Page titles (Experience, Projects, …). The Home hero uses the larger,
      // dedicated [heroName] style instead.
      displaySmall: serif(
        fontSize: 44,
        fontWeight: FontWeight.w600,
        height: 1.1,
        letterSpacing: -0.6,
        color: primary,
      ),
      // Tagline / large lead.
      headlineSmall: serif(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        height: 1.35,
        color: primary,
      ),
      // Experience / project entry titles.
      titleMedium: sans(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: primary,
      ),
      // Body prose.
      bodyLarge: sans(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        height: _bodyHeight,
        color: primary,
      ),
      bodyMedium: sans(
        fontSize: 15.5,
        fontWeight: FontWeight.w400,
        height: _bodyHeight,
        color: primary,
      ),
      // Dates, captions, tags.
      bodySmall: sans(
        fontSize: 13.5,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: primary,
      ),
    );
  }

  /// The Home hero name — larger and more confident than a page title, with
  /// tighter optical spacing. Sized responsively by the caller (the hero picks
  /// [fontSize] from the viewport width) so it stays striking on desktop yet
  /// never overflows on a phone.
  static TextStyle heroName(Color color, {double fontSize = 58}) =>
      GoogleFonts.fraunces(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        height: 1.03,
        letterSpacing: -1.2,
        color: color,
      );

  /// Small, quiet section label ("Experience", "Projects").
  static TextStyle sectionLabel(Color color) => GoogleFonts.inter(
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.6,
    color: color,
  );

  /// Tag / pill text used in the skills section.
  static TextStyle tag(Color color) => GoogleFonts.inter(
    fontSize: 13.5,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: color,
  );

  /// Editorial serif numeral for the Projects index (01, 02, …) — picks up the
  /// heading face so the index reads as a deliberate typographic mark.
  static TextStyle indexNumeral(Color color) => GoogleFonts.fraunces(
    fontSize: 19,
    fontWeight: FontWeight.w500,
    height: 1,
    letterSpacing: -0.5,
    color: color,
    fontFeatures: const [FontFeature.tabularFigures()],
  );
}
