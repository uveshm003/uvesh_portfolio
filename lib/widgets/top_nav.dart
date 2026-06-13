import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../theme/theme_controller.dart';
import '../utils/url.dart';
import 'content_container.dart';
import 'hover_link.dart';

/// A nav destination that scrolls to an in-page section.
typedef SectionTarget = ({String label, VoidCallback onTap});

/// Thin, sticky top navigation: name on the left, section + external links and
/// a theme toggle on the right. Collapses to a single menu button on mobile.
class TopNav extends StatelessWidget {
  const TopNav({
    super.key,
    required this.sections,
    required this.onHome,
    required this.controller,
  });

  final List<SectionTarget> sections;
  final VoidCallback onHome;
  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    // The full link row (name + 3 sections + 3 external links + toggle) only
    // fits comfortably on wide screens; below the desktop breakpoint we
    // collapse to a single menu button rather than crowd the bar.
    final collapse = MediaQuery.sizeOf(context).width < Breakpoints.desktop;

    return DecoratedBox(
      decoration: BoxDecoration(
        // Translucent so content scrolling under it stays calm, with a hairline.
        color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.85),
        border: Border(bottom: BorderSide(color: palette.divider)),
      ),
      child: SizedBox(
        height: AppSpacing.navHeight,
        child: ContentContainer(
          // Nav spans wider than the prose column to give the links room.
          maxWidth: 1080,
          child: Row(
            children: [
              // Left: name → scroll to top.
              HoverLink(
                label: PortfolioData.shortName,
                onTap: onHome,
                baseColor: palette.textPrimary,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              // The link cluster takes the remaining width and hugs the right
              // edge. FittedBox(scaleDown) is a safety net: it never scales at
              // real widths, but guarantees the bar can never overflow.
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: collapse
                        ? _MobileMenu(
                            sections: sections,
                            controller: controller,
                          )
                        : _DesktopLinks(
                            sections: sections,
                            controller: controller,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopLinks extends StatelessWidget {
  const _DesktopLinks({required this.sections, required this.controller});

  final List<SectionTarget> sections;
  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyMedium;

    return Row(
      children: [
        for (final s in sections) ...[
          HoverLink(label: s.label, onTap: s.onTap, style: labelStyle),
          const SizedBox(width: AppSpacing.md),
        ],
        for (final link in PortfolioData.navExternal) ...[
          HoverLink(label: link.label, url: link.url, style: labelStyle),
          const SizedBox(width: AppSpacing.md),
        ],
        _ThemeToggle(controller: controller),
      ],
    );
  }
}

/// Mobile: just the theme toggle + a popup menu of every destination.
class _MobileMenu extends StatelessWidget {
  const _MobileMenu({required this.sections, required this.controller});

  final List<SectionTarget> sections;
  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);

    return Row(
      children: [
        _ThemeToggle(controller: controller),
        const SizedBox(width: AppSpacing.xs),
        PopupMenuButton<VoidCallback>(
          icon: Icon(Icons.menu, color: palette.textPrimary, size: 22),
          tooltip: 'Menu',
          position: PopupMenuPosition.under,
          color: Theme.of(context).scaffoldBackgroundColor,
          onSelected: (action) => action(),
          itemBuilder: (context) => [
            for (final s in sections)
              PopupMenuItem<VoidCallback>(
                value: s.onTap,
                child: Text(s.label),
              ),
            const PopupMenuDivider(),
            for (final link in PortfolioData.navExternal)
              PopupMenuItem<VoidCallback>(
                value: () => openUrl(link.url),
                child: Text(link.label),
              ),
          ],
        ),
      ],
    );
  }
}

/// Sun/moon icon button that flips the theme via the [ThemeController].
class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle({required this.controller});

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final isDark = controller.isDark;

    return IconButton(
      onPressed: controller.toggle,
      tooltip: isDark ? 'Switch to light theme' : 'Switch to dark theme',
      splashRadius: 18,
      iconSize: 19,
      color: palette.textSecondary,
      icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
    );
  }
}
