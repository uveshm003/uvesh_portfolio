import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

/// Extra semantic colors that Material's [ColorScheme] doesn't model cleanly
/// (secondary/faint prose, link hover, hairline dividers). Exposed as a
/// [ThemeExtension] so widgets read them via `context` with no globals.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.textPrimary,
    required this.textSecondary,
    required this.textFaint,
    required this.accent,
    required this.accentHover,
    required this.accentSoft,
    required this.link,
    required this.linkHover,
    required this.surface,
    required this.divider,
  });

  final Color textPrimary;
  final Color textSecondary;
  final Color textFaint;
  final Color accent;
  final Color accentHover;

  /// Body-size text-link colors. Kept distinct from [accent] so links stay
  /// readable (AA) while graphical accent marks can run lighter.
  final Color link;
  final Color linkHover;

  /// A faint accent-tinted wash for hovered/selected surfaces.
  final Color accentSoft;

  /// Soft raised-paper fill for cards and pills (a hair above the page).
  final Color surface;
  final Color divider;

  static const AppPalette light = AppPalette(
    textPrimary: AppColors.lightTextPrimary,
    textSecondary: AppColors.lightTextSecondary,
    textFaint: AppColors.lightTextFaint,
    accent: AppColors.lightAccent,
    accentHover: AppColors.lightAccentHover,
    accentSoft: AppColors.lightAccentSoft,
    link: AppColors.lightLink,
    linkHover: AppColors.lightLinkHover,
    surface: AppColors.lightSurface,
    divider: AppColors.lightDivider,
  );

  static const AppPalette dark = AppPalette(
    textPrimary: AppColors.darkTextPrimary,
    textSecondary: AppColors.darkTextSecondary,
    textFaint: AppColors.darkTextFaint,
    accent: AppColors.darkAccent,
    accentHover: AppColors.darkAccentHover,
    accentSoft: AppColors.darkAccentSoft,
    link: AppColors.darkLink,
    linkHover: AppColors.darkLinkHover,
    surface: AppColors.darkSurface,
    divider: AppColors.darkDivider,
  );

  /// Convenience accessor used throughout the widgets.
  static AppPalette of(BuildContext context) =>
      Theme.of(context).extension<AppPalette>()!;

  @override
  AppPalette copyWith({
    Color? textPrimary,
    Color? textSecondary,
    Color? textFaint,
    Color? accent,
    Color? accentHover,
    Color? accentSoft,
    Color? link,
    Color? linkHover,
    Color? surface,
    Color? divider,
  }) {
    return AppPalette(
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textFaint: textFaint ?? this.textFaint,
      accent: accent ?? this.accent,
      accentHover: accentHover ?? this.accentHover,
      accentSoft: accentSoft ?? this.accentSoft,
      link: link ?? this.link,
      linkHover: linkHover ?? this.linkHover,
      surface: surface ?? this.surface,
      divider: divider ?? this.divider,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textFaint: Color.lerp(textFaint, other.textFaint, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentHover: Color.lerp(accentHover, other.accentHover, t)!,
      accentSoft: Color.lerp(accentSoft, other.accentSoft, t)!,
      link: Color.lerp(link, other.link, t)!,
      linkHover: Color.lerp(linkHover, other.linkHover, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
    );
  }
}

/// Assembles the light and dark [ThemeData] from the color, type and palette
/// tokens. This is the single place themes are composed.
class AppTheme {
  const AppTheme._();

  static ThemeData light() => _build(
    brightness: Brightness.light,
    background: AppColors.lightBackground,
    surface: AppColors.lightSurface,
    primaryText: AppColors.lightTextPrimary,
    accent: AppColors.lightAccent,
    palette: AppPalette.light,
  );

  static ThemeData dark() => _build(
    brightness: Brightness.dark,
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    primaryText: AppColors.darkTextPrimary,
    accent: AppColors.darkAccent,
    palette: AppPalette.dark,
  );

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color primaryText,
    required Color accent,
    required AppPalette palette,
  }) {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: accent,
          brightness: brightness,
        ).copyWith(
          surface: background,
          primary: accent,
          onSurface: primaryText,
          // Keep raised surfaces under our control so they track the warm
          // palette instead of the seed-derived clay-grey.
          surfaceContainerHighest: palette.surface,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      textTheme: AppTypography.textTheme(primaryText),
      dividerColor: palette.divider,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      extensions: <ThemeExtension<dynamic>>[palette],
    );
  }
}
