import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../theme/theme_controller.dart';
import 'content_container.dart';

/// Thin, sticky top navigation. The name (left) routes Home; the page links
/// (right) route to each section and highlight the active page. Collapses to a
/// single menu button on narrow screens. A theme toggle sits at the far right.
class TopNav extends StatelessWidget {
  const TopNav({super.key, required this.controller});

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final collapse = MediaQuery.sizeOf(context).width < Breakpoints.desktop;
    final location = GoRouterState.of(context).uri.path;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.9),
        border: Border(bottom: BorderSide(color: palette.divider)),
      ),
      child: SizedBox(
        height: AppSpacing.navHeight,
        child: ContentContainer(
          maxWidth: 1080,
          child: Row(
            children: [
              _NameLink(),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: collapse
                        ? _MobileMenu(
                            location: location,
                            controller: controller,
                          )
                        : _DesktopLinks(
                            location: location,
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

/// The name on the left - routes to Home.
class _NameLink extends StatefulWidget {
  @override
  State<_NameLink> createState() => _NameLinkState();
}

class _NameLinkState extends State<_NameLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go('/'),
        behavior: HitTestBehavior.opaque,
        child: Text(
          PortfolioData.shortName,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: _hovered ? palette.accent : palette.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _DesktopLinks extends StatelessWidget {
  const _DesktopLinks({required this.location, required this.controller});

  final String location;
  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final item in PortfolioData.navItems) ...[
          _NavLink(item: item, active: _isActive(item.path, location)),
          const SizedBox(width: AppSpacing.lg),
        ],
        _ThemeToggle(controller: controller),
      ],
    );
  }
}

/// Mobile: theme toggle + a popup menu of every page.
class _MobileMenu extends StatelessWidget {
  const _MobileMenu({required this.location, required this.controller});

  final String location;
  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);

    return Row(
      children: [
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
                  style: TextStyle(
                    color: _isActive(item.path, location)
                        ? palette.accent
                        : palette.textPrimary,
                    fontWeight: _isActive(item.path, location)
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// A single desktop nav link with hover + active states.
class _NavLink extends StatefulWidget {
  const _NavLink({required this.item, required this.active});

  final NavItem item;
  final bool active;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final theme = Theme.of(context);
    final highlight = widget.active || _hovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go(widget.item.path),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item.label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: highlight ? palette.accent : palette.textSecondary,
                fontWeight: widget.active ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            const SizedBox(height: 3),
            // Underline marks the active page; fades in on hover otherwise.
            AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              height: 1.5,
              width: highlight ? 16 : 0,
              decoration: BoxDecoration(
                color: palette.accent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
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
      splashRadius: 18,
      iconSize: 19,
      color: palette.textSecondary,
      icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
    );
  }
}

/// Home ('/') matches only exactly; other pages match their path prefix.
bool _isActive(String path, String location) {
  if (path == '/') return location == '/';
  return location == path || location.startsWith('$path/');
}
