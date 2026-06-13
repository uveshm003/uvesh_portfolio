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
      // Hero name.
      displaySmall: serif(
        fontSize: 42,
        fontWeight: FontWeight.w600,
        height: 1.1,
        letterSpacing: -0.5,
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
}
