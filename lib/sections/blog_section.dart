import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../widgets/category_filter.dart';
import '../widgets/fade_in.dart';
import 'reading_widgets.dart';

/// Blog - writing entries as quiet cards (date kicker, title, summary, topic
/// tags), filtered by category, or a tidy empty state until the first post is
/// added to [PortfolioData.blogs].
class BlogContent extends StatelessWidget {
  const BlogContent({super.key});

  @override
  Widget build(BuildContext context) {
    final blogs = PortfolioData.blogs;
    if (blogs.isEmpty) {
      return const ReadingEmptyState(
        icon: Icons.edit_note_outlined,
        message: "I'm setting up my writing space - notes on Flutter, "
            'cross-platform engineering and devices will land here soon.',
      );
    }

    return CategoryFilteredList<BlogPost>(
      items: blogs,
      categoryOf: (p) => p.category,
      emptyMessage: const ReadingEmptyState(
        icon: Icons.edit_note_outlined,
        message: 'No posts in this category yet - try another.',
      ),
      builder: (context, posts) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < posts.length; i++) ...[
            if (i > 0) const SizedBox(height: AppSpacing.md),
            FadeIn(
              delay: Duration(milliseconds: 60 * (i < 5 ? i : 5)),
              child: _BlogCard(posts[i]),
            ),
          ],
        ],
      ),
    );
  }
}

class _BlogCard extends StatefulWidget {
  const _BlogCard(this.post);

  final BlogPost post;

  @override
  State<_BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<_BlogCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppPalette.of(context);
    final post = widget.post;

    return ReadingCard(
      url: post.url,
      semanticLabel: post.title,
      onHover: (v) => setState(() => _hovered = v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date · reading-time kicker.
          Text(
            post.readingTime != null
                ? '${post.date}  ·  ${post.readingTime}'
                : post.date,
            style: theme.textTheme.bodySmall?.copyWith(color: palette.textFaint),
          ),
          const SizedBox(height: AppSpacing.xs),
          ReadingTitleRow(
            title: post.title,
            hovered: _hovered,
            hasLink: post.url != null,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            post.summary,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: palette.textSecondary,
            ),
          ),
          if (post.tags.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [for (final t in post.tags) TagPill(t)],
            ),
          ],
        ],
      ),
    );
  }
}
