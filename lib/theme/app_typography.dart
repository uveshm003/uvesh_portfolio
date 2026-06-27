import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography tokens.
///
/// Three roles, tuned for a "warm editorial" identity — a hand-set page, not a
/// machine-generated spec sheet:
///   • Display / name  -> Fraunces (a soft, characterful old-style serif with
///                        real warmth in its terminals — the hand-picked voice
///                        that gives the page fingerprints)
///   • Body / prose    -> Inter (a calm, highly readable humanist workhorse)
///   • Data only       -> IBM Plex Mono, used sparingly — dates, tech tags and
///                        register indices, where a monospace genuinely reads as
///                        data. Eyebrows and labels are NOT mono; that machine
///                        voice is what made the old design feel generated.
///
/// All sizes live here as a clear scale; widgets reference the resulting
/// [TextTheme] or the named helper styles rather than inventing their own.
class AppTypography {
  const AppTypography._();

  static const double _bodyHeight = 1.7;

  /// Builds the Material [TextTheme] for a given foreground color.
  static TextTheme textTheme(Color primary) {
    final display = GoogleFonts.fraunces;
    final sans = GoogleFonts.inter;

    return TextTheme(
      // Page titles (Experience, Projects, …). The Home hero uses the larger,
      // dedicated [heroName] style instead.
      displaySmall: display(
        fontSize: 44,
        fontWeight: FontWeight.w600,
        height: 1.04,
        letterSpacing: -0.5,
        color: primary,
      ),
      // Lead line under a page title.
      headlineSmall: sans(
        fontSize: 19,
        fontWeight: FontWeight.w400,
        height: 1.55,
        letterSpacing: -0.1,
        color: primary,
      ),
      // Experience / project entry titles.
      titleMedium: display(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.25,
        letterSpacing: -0.2,
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

  /// The Home hero name / statement — the loudest type on the site. Fraunces at
  /// display weight, optically tightened. Sized responsively by the caller so it
  /// stays striking on desktop yet never overflows on a phone.
  static TextStyle heroName(Color color, {double fontSize = 64}) =>
      GoogleFonts.fraunces(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        height: 1.0,
        letterSpacing: -0.5,
        color: color,
      );

  // ---- Labels & data --------------------------------------------------------

  /// Small, quiet section label / eyebrow ("EXPERIENCE", "PROJECTS"). A tracked
  /// humanist sans in small caps — warm, not mechanical. (Deliberately NOT
  /// monospace: the all-mono labels were the tell that made the page read as
  /// auto-generated.)
  static TextStyle sectionLabel(Color color) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.8,
    height: 1.4,
    color: color,
  );

  /// General-purpose monospace run (file-path metadata, inline data). Used
  /// sparingly — only where a value genuinely reads as data.
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

  /// Tag / pill text used for tech stacks and topics — monospace so stacks read
  /// as machine-listed tokens (one of the few places mono still earns its keep).
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
