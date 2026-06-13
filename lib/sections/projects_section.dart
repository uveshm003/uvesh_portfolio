import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../utils/url.dart';

/// Projects - selected work as quiet, numbered cards: an index, title and
/// category, a tech-tag row, and a short description. Cards with a link lift
/// gently and reveal an arrow on hover. Restrained, but a touch more crafted
/// than the plain list elsewhere.
class ProjectsContent extends StatelessWidget {
  const ProjectsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < PortfolioData.projects.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.md),
          _ProjectCard(index: i + 1, project: PortfolioData.projects[i]),
        ],
      ],
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.index, required this.project});

  final int index;
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
    final active = _hovered && _hasLink;

    final card = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      // A gentle lift on hover for linked cards.
      transform: Matrix4.translationValues(0, active ? -2 : 0, 0),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: _hovered
            ? theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: active ? palette.accent.withValues(alpha: 0.6) : palette.divider,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeaderRow(
            index: widget.index,
            project: project,
            hovered: _hovered,
            hasLink: _hasLink,
          ),
          const SizedBox(height: AppSpacing.sm),
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
          label: '${project.title} - open project',
          child: card,
        ),
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({
    required this.index,
    required this.project,
    required this.hovered,
    required this.hasLink,
  });

  final int index;
  final Project project;
  final bool hovered;
  final bool hasLink;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppPalette.of(context);
    final titleColor = (hovered && hasLink) ? palette.accent : palette.textPrimary;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Editorial index - 01, 02, …
        Padding(
          padding: const EdgeInsets.only(top: 2, right: AppSpacing.sm),
          child: Text(
            index.toString().padLeft(2, '0'),
            style: theme.textTheme.bodySmall?.copyWith(
              color: palette.accent.withValues(alpha: 0.7),
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ),
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xxs,
            children: [
              Text(
                project.title,
                style: theme.textTheme.titleMedium?.copyWith(color: titleColor),
              ),
              _CategoryTag(project.category),
            ],
          ),
        ),
        // Arrow affordance for linked projects; slides in on hover.
        if (hasLink)
          AnimatedOpacity(
            duration: const Duration(milliseconds: 180),
            opacity: hovered ? 1 : 0.45,
            child: Icon(
              Icons.north_east,
              size: 17,
              color: hovered ? palette.accent : palette.textFaint,
            ),
          ),
      ],
    );
  }
}

class _CategoryTag extends StatelessWidget {
  const _CategoryTag(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return Text(
      label.toUpperCase(),
      style: AppTypography.sectionLabel(palette.textFaint).copyWith(
        fontSize: 10.5,
        letterSpacing: 1.2,
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
              horizontal: AppSpacing.xs + 1,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: palette.divider),
            ),
            child: Text(
              item,
              style: AppTypography.tag(
                palette.textSecondary,
              ).copyWith(fontSize: 12),
            ),
          ),
      ],
    );
  }
}
