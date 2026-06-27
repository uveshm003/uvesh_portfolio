/// Spacing, sizing and layout tokens.
///
/// Everything that controls rhythm lives here so the widgets never hard-code
/// magic numbers. Values follow a loose 4px base scale.
class AppSpacing {
  const AppSpacing._();

  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 72;
  static const double huge = 112;

  /// Comfortable reading measure for body prose (centered column cap).
  static const double contentMaxWidth = 700;

  /// Wider measure for the Home hero, where a monospace meta-rail sits beside
  /// the main column.
  static const double wideMaxWidth = 940;

  /// Fixed width of the Home meta-rail on desktop.
  static const double metaRailWidth = 188;

  /// Fixed width of the persistent left sidebar on desktop.
  static const double sidebarWidth = 312;

  /// Horizontal padding inside the content pane on desktop.
  static const double paneGutter = 80;

  /// Reading measure inside the content pane (left-aligned, not centered).
  static const double paneMaxWidth = 880;

  /// Height of the collapsed mobile top bar.
  static const double mobileBarHeight = 60;

  /// Horizontal page gutter on small screens.
  static const double gutterMobile = 22;

  /// Horizontal page gutter on wider screens.
  static const double gutterWide = 32;

  /// Profile photo diameter in the hero.
  static const double avatarSize = 116;

  /// Height of the sticky top navigation bar.
  static const double navHeight = 64;
}

/// Responsive breakpoints. We layout mobile-first and widen from there.
class Breakpoints {
  const Breakpoints._();

  static const double tablet = 640;
  static const double desktop = 1024;

  static bool isMobile(double w) => w < tablet;
  static bool isTablet(double w) => w >= tablet && w < desktop;
  static bool isDesktop(double w) => w >= desktop;
}
