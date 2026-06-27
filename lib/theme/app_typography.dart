import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography tokens.
///
/// Three roles, each doing a distinct job in the "instrument" identity:
///   • Display / name  -> Space Grotesk (a technical grotesque with real
///                        character in its numerals and ampersands)
///   • Body / prose    -> Inter (a neutral, highly readable workhorse)
///   • Data / labels   -> IBM Plex Mono (dates, tags, indices, eyebrows — the
///                        monospace voice that makes the page read like a
///                        precise spec sheet rather than a blog)
///
/// All sizes live here as a clear scale; widgets reference the resulting
/// [TextTheme] or the named helper styles rather than inventing their own.
class AppTypography {
  const AppTypography._();

  static const double _bodyHeight = 1.7;

  /// Builds the Material [TextTheme] for a given foreground color.
  static TextTheme textTheme(Color primary) {
    final display = GoogleFonts.spaceGrotesk;
    final sans = GoogleFonts.inter;

    return TextTheme(
      // Page titles (Experience, Projects, …). The Home hero uses the larger,
      // dedicated [heroName] style instead.
      displaySmall: display(
        fontSize: 42,
        fontWeight: FontWeight.w600,
        height: 1.04,
        letterSpacing: -1.0,
        color: primary,
      ),
      // Lead line under a page title.
      headlineSmall: sans(
        fontSize: 19,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: -0.1,
        color: primary,
      ),
      // Experience / project entry titles.
      titleMedium: display(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: -0.3,
        color: primary,
      ),
      // Body prose.
      bodyLarge: sans(
        fontSize: 16.5,
        fontWeight: FontWeight.w400,
        height: _bodyHeight,
        letterSpacing: -0.1,
        color: primary,
      ),
      bodyMedium: sans(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: _bodyHeight,
        letterSpacing: -0.1,
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

  /// The Home hero name — the loudest type on the site. Space Grotesk at weight,
  /// optically tightened. Sized responsively by the caller (the hero picks
  /// [fontSize] from the viewport) so it stays striking on desktop yet never
  /// overflows on a phone.
  static TextStyle heroName(Color color, {double fontSize = 64}) =>
      GoogleFonts.spaceGrotesk(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        height: 0.98,
        letterSpacing: -1.6,
        color: color,
      );

  // ---- Monospace voice ------------------------------------------------------

  /// General-purpose monospace run (file-path metadata, inline data).
  static TextStyle mono(
    Color color, {
    double fontSize = 13,
    FontWeight weight = FontWeight.w400,
    double letterSpacing = 0,
    double height = 1.5,
  }) => GoogleFonts.ibmPlexMono(
    fontSize: fontSize,
    fontWeight: weight,
    letterSpacing: letterSpacing,
    height: height,
    color: color,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  /// Small, quiet section label / eyebrow ("EXPERIENCE", "PROJECTS"). The
  /// monospace, wide-tracked uppercase mark is the signature device that ties
  /// every section together.
  static TextStyle sectionLabel(Color color) => GoogleFonts.ibmPlexMono(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 2.0,
    height: 1.4,
    color: color,
  );

  /// Tag / pill text used for tech stacks and topics — monospace so stacks read
  /// as machine-listed tokens.
  static TextStyle tag(Color color) => GoogleFonts.ibmPlexMono(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 0.2,
    color: color,
  );

  /// Editorial numeral for indices (01, 02, …) — monospace, tabular, so the
  /// index column aligns like a printed register.
  static TextStyle indexNumeral(Color color) => GoogleFonts.ibmPlexMono(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1,
    letterSpacing: 0.5,
    color: color,
    fontFeatures: const [FontFeature.tabularFigures()],
  );
}
