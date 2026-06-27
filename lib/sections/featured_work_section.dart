import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../utils/url.dart';

/// Home "Featured Work": the marquee projects shown as a responsive card grid
/// (two-up on desktop, single column otherwise). Deliberately card-based so it
/// reads differently from the full-width numbered index on the Projects page,
/// and capped at a handful with an "All projects" link to the full list.
class FeaturedWorkContent extends StatelessWidget {
  const FeaturedWorkContent({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final projects = PortfolioData.featuredProjects;
    final width = MediaQuery.sizeOf(context).width;
    final twoUp = width >= Breakpoints.desktop;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = twoUp
            ? (constraints.maxWidth - AppSpacing.md) / 2
            : constraints.maxWidth;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: [
                for (final p in projects)
                  SizedBox(width: cardWidth, child: _ProjectCard(project: p)),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            _AllProjectsLink(palette: palette),
          ],
        );
      },
    );
  }
}

class _AllProjectsLink extends StatefulWidget {
  const _AllProjectsLink({required this.palette});

  final AppPalette palette;

  @override
  State<_AllProjectsLink> createState() => _AllProjectsLinkState();
}

class _AllProjectsLinkState extends State<_AllProjectsLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final palette = widget.palette;
    final color = _hovered ? palette.accentHover : palette.accent;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go('/projects'),
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'ALL PROJECTS',
              style: AppTypography.sectionLabel(color),
            ),
            const SizedBox(width: AppSpacing.xs),
            AnimatedSlide(
              duration: const Duration(milliseconds: 150),
              offset: Offset(_hovered ? 0.25 : 0, 0),
              child: Icon(Icons.arrow_forward, size: 15, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.project});

  final Project project;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;
  bool get _hasLink => widget.project.url != null;

  void _setHover(bool v) {
    if (_hovered != v) setState(() => _hovered = v);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppPalette.of(context);
    final project = widget.project;
    final lifted = _hovered;

    final card = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: lifted ? palette.accentSoft : palette.surface.withValues(alpha: 0.6),
        border: Border.all(
          color: lifted ? palette.accent : palette.divider,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                project.category.toUpperCase(),
                style: AppTypography.sectionLabel(palette.textFaint)
                    .copyWith(fontSize: 10.5, letterSpacing: 1.4),
              ),
              const Spacer(),
              if (_hasLink)
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 160),
                  opacity: lifted ? 1 : 0.4,
                  child: Icon(
                    Icons.north_east,
                    size: 17,
                    color: lifted ? palette.accent : palette.textFaint,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            project.title,
            style: AppTypography.heroName(
              lifted && _hasLink ? palette.accent : palette.textPrimary,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            project.description,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: palette.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _MiniTechRow(items: project.techItems),
        ],
      ),
    );

    if (!_hasLink) {
      return MouseRegion(
        onEnter: (_) => _setHover(true),
        onExit: (_) => _setHover(false),
        child: card,
      );
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _setHover(true),
      onExit: (_) => _setHover(false),
      child: GestureDetector(
        onTap: () => openUrl(project.url!),
        behavior: HitTestBehavior.opaque,
        child: Semantics(
          link: true,
          label: '${project.title}, open project',
          child: card,
        ),
      ),
    );
  }
}

/// A compact, single-line-ish tech list for the card — the first few tokens as
/// mono pills, with a "+N" overflow marker so cards stay even in height.
class _MiniTechRow extends StatelessWidget {
  const _MiniTechRow({required this.items});

  final List<String> items;

  static const int _max = 4;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final shown = items.take(_max).toList();
    final extra = items.length - shown.length;

    Widget pill(String text) => Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs + 2, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: palette.divider),
      ),
      child: Text(
        text,
        style: AppTypography.tag(palette.textSecondary).copyWith(fontSize: 11.5),
      ),
    );

    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: [
        for (final t in shown) pill(t),
        if (extra > 0) pill('+$extra'),
      ],
    );
  }
}
