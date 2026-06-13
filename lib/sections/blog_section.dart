import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../utils/url.dart';

/// Blog - a list of writing entries, or a tidy empty state until the first
/// post is added to [PortfolioData.blogs].
class BlogContent extends StatelessWidget {
  const BlogContent({super.key});

  @override
  Widget build(BuildContext context) {
    final blogs = PortfolioData.blogs;
    if (blogs.isEmpty) return const _EmptyState();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < blogs.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.xl),
          _BlogEntry(blogs[i]),
        ],
      ],
    );
  }
}

class _BlogEntry extends StatefulWidget {
  const _BlogEntry(this.post);

  final BlogPost post;

  @override
  State<_BlogEntry> createState() => _BlogEntryState();
}

class _BlogEntryState extends State<_BlogEntry> {
  bool _hovered = false;
  bool get _hasLink => widget.post.url != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppPalette.of(context);
    final active = _hovered && _hasLink;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.post.date,
          style: theme.textTheme.bodySmall?.copyWith(color: palette.textFaint),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                widget.post.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: active ? palette.accent : palette.textPrimary,
                ),
              ),
            ),
            if (_hasLink)
              Icon(
                Icons.north_east,
                size: 17,
                color: active ? palette.accent : palette.textFaint,
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          widget.post.summary,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: palette.textSecondary,
          ),
        ),
      ],
    );

    if (!_hasLink) return content;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => openUrl(widget.post.url!),
        behavior: HitTestBehavior.opaque,
        child: Semantics(link: true, label: widget.post.title, child: content),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppPalette.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xxl,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: palette.divider),
      ),
      child: Row(
        children: [
          Icon(Icons.edit_note_outlined, color: palette.textFaint, size: 22),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              "I'm setting up my writing space - notes on Flutter, "
              "cross-platform engineering and devices will land here soon.",
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
