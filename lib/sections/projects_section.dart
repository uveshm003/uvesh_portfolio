import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../utils/url.dart';

/// Projects — selected work as a large, numbered index. Each entry is a
/// full-width row separated by a hairline: a big mono index, a large title with
/// its category, a tech-stack row and a short description. Linked entries warm
/// to an accent wash, shift their title to accent and reveal an arrow on hover.
class ProjectsContent extends StatelessWidget {
  const ProjectsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final projects = PortfolioData.projects;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top rule opens the index.
        Container(height: 1, color: palette.divider),
        for (var i = 0; i < projects.length; i++)
          _ProjectRow(index: i + 1, project: projects[i]),
      ],
    );
  }
}

class _ProjectRow extends StatefulWidget {
  const _ProjectRow({required this.index, required this.project});

  final int index;
  final Project project;

  @override
  State<_ProjectRow> createState() => _ProjectRowState();
}

class _ProjectRowState extends State<_ProjectRow> {
  bool _hovered = false;
  bool get _hasLink => widget.project.url != null;
  bool get _active => _hovered && _hasLink;

  void _setHover(bool v) {
    if (_hovered != v) setState(() => _hovered = v);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppPalette.of(context);
    final project = widget.project;
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < Breakpoints.tablet;

    final titleColor = _active ? palette.accent : palette.textPrimary;

    final row = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: _active ? palette.accentSoft : Colors.transparent,
        border: Border(bottom: BorderSide(color: palette.divider)),
      ),
      padding: EdgeInsets.fromLTRB(
        _active ? AppSpacing.md : 0,
        AppSpacing.xl,
        0,
        AppSpacing.xl,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Big index numeral.
          SizedBox(
            width: compact ? 44 : 72,
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                widget.index.toString().padLeft(2, '0'),
                style: AppTypography.mono(
                  _active ? palette.accent : palette.textFaint,
                  fontSize: compact ? 16 : 20,
                  weight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + category + arrow.
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: AppSpacing.md,
                        runSpacing: AppSpacing.xxs,
                        children: [
                          Text(
                            project.title,
                            style: AppTypography.heroName(
                              titleColor,
                              fontSize: compact ? 24 : 30,
                            ),
                          ),
                          Text(
                            project.category.toUpperCase(),
                            style: AppTypography.sectionLabel(
                              palette.textFaint,
                            ).copyWith(fontSize: 10.5, letterSpacing: 1.4),
                          ),
                        ],
                      ),
                    ),
                    if (_hasLink)
                      Padding(
                        padding: const EdgeInsets.only(top: 4, left: AppSpacing.sm),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 160),
                          opacity: _hovered ? 1 : 0.35,
                          child: Icon(
                            Icons.north_east,
                            size: 20,
                            color: _active ? palette.accent : palette.textFaint,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                _TechTags(items: project.techItems),
                const SizedBox(height: AppSpacing.md),
                Text(
                  project.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: palette.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (!_hasLink) {
      return MouseRegion(
        onEnter: (_) => _setHover(true),
        onExit: (_) => _setHover(false),
        child: row,
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
          child: row,
        ),
      ),
    );
  }
}

class _TechTags extends StatelessWidget {
  const _TechTags({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: [
        for (final item in items)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: palette.surface.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: palette.divider),
            ),
            child: Text(
              item,
              style: AppTypography.tag(palette.textSecondary).copyWith(fontSize: 12),
            ),
          ),
      ],
    );
  }
}
