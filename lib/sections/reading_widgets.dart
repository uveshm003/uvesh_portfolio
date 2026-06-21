import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../utils/url.dart';

/// Shared building blocks for the reading-related sections (Currently Reading,
/// Bookshelf, Research Papers) and the Blog page, so they all share one quiet,
/// editorial card language: soft raised paper that warms to an accent wash and
/// lifts gently on hover when it links out.

/// A raised-paper card that handles the hover-lift, accent wash, link affordance
/// and tap-through. Hosts arbitrary [child] content.
class ReadingCard extends StatefulWidget {
  const ReadingCard({
    super.key,
    required this.child,
    this.url,
    this.semanticLabel,
    this.onHover,
  });

  final Widget child;

  /// When non-null the card becomes clickable and lifts on hover.
  final String? url;
  final String? semanticLabel;

  /// Lets the parent track hover so it can recolor its own title/arrow.
  final ValueChanged<bool>? onHover;

  @override
  State<ReadingCard> createState() => _ReadingCardState();
}

class _ReadingCardState extends State<ReadingCard> {
  bool _hovered = false;
  bool get _hasLink => widget.url != null;

  void _setHover(bool v) {
    if (_hovered == v) return;
    setState(() => _hovered = v);
    widget.onHover?.call(v);
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final active = _hovered && _hasLink;

    final card = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      transform: Matrix4.translationValues(0, active ? -3 : 0, 0),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: active
            ? palette.accentSoft
            : _hovered
            ? palette.surface
            : palette.surface.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: active ? palette.accent.withValues(alpha: 0.55) : palette.divider,
        ),
        boxShadow: active
            ? [
                BoxShadow(
                  color: palette.accent.withValues(alpha: 0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: widget.child,
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
        onTap: () => openUrl(widget.url!),
        behavior: HitTestBehavior.opaque,
        child: Semantics(
          link: true,
          label: widget.semanticLabel,
          child: card,
        ),
      ),
    );
  }
}

/// A title line with an optional trailing tag pill and a hover-aware link arrow.
class ReadingTitleRow extends StatelessWidget {
  const ReadingTitleRow({
    super.key,
    required this.title,
    required this.hovered,
    required this.hasLink,
    this.trailing,
  });

  final String title;
  final bool hovered;
  final bool hasLink;

  /// Optional widget shown beside the title (e.g. a [TagPill]).
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppPalette.of(context);
    final active = hovered && hasLink;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xxs,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: active ? palette.accent : palette.textPrimary,
                ),
              ),
              ?trailing,
            ],
          ),
        ),
        if (hasLink)
          Padding(
            padding: const EdgeInsets.only(left: AppSpacing.sm, top: 2),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              opacity: hovered ? 1 : 0.45,
              child: Icon(
                Icons.north_east,
                size: 16,
                color: active ? palette.accent : palette.textFaint,
              ),
            ),
          ),
      ],
    );
  }
}

/// A small uppercase pill (genre / topic). Quiet, raised-paper styling that
/// echoes the project tech tags.
class TagPill extends StatelessWidget {
  const TagPill(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs + 2, vertical: 3),
      decoration: BoxDecoration(
        color: palette.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: palette.divider),
      ),
      child: Text(
        label.toUpperCase(),
        style: AppTypography.sectionLabel(palette.textFaint).copyWith(
          fontSize: 10,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

/// A tidy empty state shared by the reading sections: a bordered panel with an
/// icon and a friendly note.
class ReadingEmptyState extends StatelessWidget {
  const ReadingEmptyState({super.key, required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppPalette.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: palette.divider),
      ),
      child: Row(
        children: [
          Icon(icon, color: palette.textFaint, size: 22),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: palette.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
