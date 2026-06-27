import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../theme/theme_controller.dart';
import 'hover_link.dart';

/// The persistent left identity panel shown on desktop. It stays fixed while
/// the content pane scrolls: name, role, a vertical section index with an
/// active marker, a "now" status line, external links and the theme toggle.
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
            // Section index.
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final item in PortfolioData.navItems)
                      _NavRow(
                        item: item,
                        active: _isActive(item.path, location),
                      ),
                  ],
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
                _ThemeToggle(controller: controller),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// One vertical nav row: a leading marker that fills with accent when active,
/// the label, and a trailing two-digit index. Hover lifts the label color.
class _NavRow extends StatefulWidget {
  const _NavRow({required this.item, required this.active});

  final NavItem item;
  final bool active;

  @override
  State<_NavRow> createState() => _NavRowState();
}

class _NavRowState extends State<_NavRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final highlight = widget.active || _hovered;
    final index = PortfolioData.navItems.indexOf(widget.item) + 1;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go(widget.item.path),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs + 1),
          child: Row(
            children: [
              // Active marker.
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: widget.active ? 18 : (_hovered ? 12 : 8),
                height: 2,
                margin: const EdgeInsets.only(right: AppSpacing.sm),
                color: highlight ? palette.accent : palette.divider,
              ),
              Expanded(
                child: Text(
                  widget.item.label,
                  style: AppTypography.mono(
                    highlight ? palette.textPrimary : palette.textSecondary,
                    fontSize: 14.5,
                    weight: widget.active ? FontWeight.w500 : FontWeight.w400,
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
    );
  }
}

/// The collapsed top bar shown on narrow screens: name (routes Home), the theme
/// toggle and a popup section menu.
class MobileBar extends StatelessWidget {
  const MobileBar({super.key, required this.controller});

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final location = GoRouterState.of(context).uri.path;

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
              PortfolioData.shortName.toUpperCase(),
              style: AppTypography.mono(
                palette.textPrimary,
                fontSize: 13.5,
                weight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const Spacer(),
          _ThemeToggle(controller: controller),
          const SizedBox(width: AppSpacing.xs),
          PopupMenuButton<String>(
            icon: Icon(Icons.menu, color: palette.textPrimary, size: 22),
            tooltip: 'Menu',
            position: PopupMenuPosition.under,
            color: Theme.of(context).scaffoldBackgroundColor,
            onSelected: (path) => context.go(path),
            itemBuilder: (context) => [
              for (final item in PortfolioData.navItems)
                PopupMenuItem<String>(
                  value: item.path,
                  child: Text(
                    item.label,
                    style: AppTypography.mono(
                      _isActive(item.path, location)
                          ? palette.accent
                          : palette.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

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
      iconSize: 19,
      color: palette.textSecondary,
      icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
    );
  }
}

bool _isActive(String path, String location) {
  if (path == '/') return location == '/';
  return location == path || location.startsWith('$path/');
}
