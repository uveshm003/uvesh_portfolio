import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../theme/theme_controller.dart';
import 'hover_link.dart';

/// The persistent left identity panel shown on desktop. It stays fixed while
/// the content pane scrolls: name, role, a section index where the active page
/// is marked with a soft accent pill, a "now" status line, external links and
/// the theme toggle.
class Sidebar extends StatelessWidget {
  const Sidebar({super.key, required this.controller});

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final location = GoRouterState.of(context).uri.path;

    return Container(
      width: AppSpacing.sidebarWidth,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: palette.divider)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.xxl,
          AppSpacing.xxl,
          AppSpacing.xl,
          AppSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Identity.
            GestureDetector(
              onTap: () => context.go('/'),
              behavior: HitTestBehavior.opaque,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Muhammad',
                      style: AppTypography.heroName(
                        palette.textPrimary,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'Uvesh Menpurwala',
                      style: AppTypography.heroName(
                        palette.textPrimary,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              PortfolioData.tagline.toUpperCase(),
              style: AppTypography.sectionLabel(palette.accent),
            ),

            const SizedBox(height: AppSpacing.xxl),
            // Section index. The slight negative margin lets the active pill
            // bleed back to the optical edge of the name above it.
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final item in PortfolioData.navItems)
                        NavPill(
                          item: item,
                          active: isActiveRoute(item.path, location),
                          onTap: () => context.go(item.path),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.lg),
            Container(height: 1, color: palette.divider),
            const SizedBox(height: AppSpacing.lg),

            // Now.
            Text('NOW', style: AppTypography.sectionLabel(palette.textFaint)),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Software Engineer at Sensit\nTechnologies (Halma PLC)',
              style: AppTypography.mono(palette.textSecondary, fontSize: 12.5),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Links + theme toggle.
            Row(
              children: [
                for (final link in PortfolioData.navExternal) ...[
                  HoverLink(
                    label: link.label,
                    url: link.url,
                    baseColor: palette.textSecondary,
                    style: AppTypography.mono(
                      palette.textSecondary,
                      fontSize: 12.5,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                ],
                const Spacer(),
                ThemeToggle(controller: controller),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// One navigation row rendered as a pill: the active page fills with a soft
/// accent wash and an accent label; hover lifts inactive rows onto a faint
/// surface. The trailing two-digit index keeps the printed-register feel.
class NavPill extends StatefulWidget {
  const NavPill({
    super.key,
    required this.item,
    required this.active,
    required this.onTap,
  });

  final NavItem item;
  final bool active;
  final VoidCallback onTap;

  @override
  State<NavPill> createState() => _NavPillState();
}

class _NavPillState extends State<NavPill> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final active = widget.active;
    final highlight = active || _hovered;
    final index = PortfolioData.navItems.indexOf(widget.item) + 1;

    final Color bg = active
        ? palette.accentSoft
        : (_hovered ? palette.surface : Colors.transparent);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs + 2,
            ),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: active
                    ? palette.accent.withValues(alpha: 0.28)
                    : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.item.label,
                    style: AppTypography.sectionLabel(
                      active
                          ? palette.accent
                          : (highlight ? palette.textPrimary : palette.textSecondary),
                    ).copyWith(
                      fontSize: 13,
                      letterSpacing: 0.6,
                      fontWeight: active ? FontWeight.w700 : FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  index.toString().padLeft(2, '0'),
                  style: AppTypography.mono(
                    highlight ? palette.accent : palette.textFaint,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The collapsed top bar shown on narrow screens: name (routes Home), the theme
/// toggle and a hamburger that opens the navigation [NavDrawer].
class MobileBar extends StatelessWidget {
  const MobileBar({super.key, required this.controller, required this.onMenu});

  final ThemeController controller;
  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);

    return Container(
      height: AppSpacing.mobileBarHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(bottom: BorderSide(color: palette.divider)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.go('/'),
            behavior: HitTestBehavior.opaque,
            child: Text(
              PortfolioData.shortName,
              style: AppTypography.heroName(palette.textPrimary, fontSize: 19),
            ),
          ),
          const Spacer(),
          ThemeToggle(controller: controller),
          const SizedBox(width: AppSpacing.xs),
          IconButton(
            icon: Icon(Icons.menu_rounded, color: palette.textPrimary, size: 24),
            tooltip: 'Menu',
            onPressed: onMenu,
          ),
        ],
      ),
    );
  }
}

/// The slide-in navigation drawer for narrow screens: identity, the section
/// index as pills, then external links and the theme toggle.
class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key, required this.controller});

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final location = GoRouterState.of(context).uri.path;
    final bg = Theme.of(context).scaffoldBackgroundColor;

    void goAndClose(String path) {
      Navigator.of(context).pop();
      context.go(path);
    }

    return Drawer(
      backgroundColor: bg,
      shape: Border(left: BorderSide(color: palette.divider)),
      width: 296,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.xl,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      PortfolioData.shortName,
                      style: AppTypography.heroName(
                        palette.textPrimary,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close_rounded, color: palette.textSecondary),
                    tooltip: 'Close',
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                PortfolioData.tagline.toUpperCase(),
                style: AppTypography.sectionLabel(palette.accent),
              ),
              const SizedBox(height: AppSpacing.xl),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final item in PortfolioData.navItems)
                        NavPill(
                          item: item,
                          active: isActiveRoute(item.path, location),
                          onTap: () => goAndClose(item.path),
                        ),
                    ],
                  ),
                ),
              ),
              Container(height: 1, color: palette.divider),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  for (final link in PortfolioData.navExternal) ...[
                    HoverLink(
                      label: link.label,
                      url: link.url,
                      baseColor: palette.textSecondary,
                      style: AppTypography.mono(
                        palette.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                  ],
                  const Spacer(),
                  ThemeToggle(controller: controller),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key, required this.controller});

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final isDark = controller.isDark;

    return IconButton(
      onPressed: controller.toggle,
      tooltip: isDark ? 'Switch to light theme' : 'Switch to dark theme',
      iconSize: 19,
      color: palette.textSecondary,
      icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
    );
  }
}

/// Home ('/') matches only exactly; other pages match their path prefix.
bool isActiveRoute(String path, String location) {
  if (path == '/') return location == '/';
  return location == path || location.startsWith('$path/');
}
