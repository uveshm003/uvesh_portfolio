import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../widgets/category_filter.dart';
import '../widgets/fade_in.dart';
import 'reading_widgets.dart';

/// Research papers - a small shelf of papers worth reading, filtered by
/// category, each a card that carries publication metadata
/// (authors · venue · year), a short note on why it matters, and a topic-tag row.
class ResearchPapersContent extends StatelessWidget {
  const ResearchPapersContent({super.key});

  @override
  Widget build(BuildContext context) {
    final papers = PortfolioData.researchPapers;
    if (papers.isEmpty) {
      return const ReadingEmptyState(
        icon: Icons.article_outlined,
        message: 'The papers that shaped how I think about distributed and '
            'offline-first systems will land here soon.',
      );
    }

    return CategoryFilteredList<ResearchPaper>(
      items: papers,
      categoryOf: (p) => p.category,
      emptyMessage: const ReadingEmptyState(
        icon: Icons.article_outlined,
        message: 'No papers in this category yet - try another.',
      ),
      builder: (context, list) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < list.length; i++) ...[
            if (i > 0) const SizedBox(height: AppSpacing.sm),
            FadeIn(
              delay: Duration(milliseconds: 60 * (i < 5 ? i : 5)),
              child: _PaperCard(list[i]),
            ),
          ],
        ],
      ),
    );
  }
}

class _PaperCard extends StatefulWidget {
  const _PaperCard(this.paper);

  final ResearchPaper paper;

  @override
  State<_PaperCard> createState() => _PaperCardState();
}

class _PaperCardState extends State<_PaperCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppPalette.of(context);
    final paper = widget.paper;

    return ReadingCard(
      url: paper.url,
      semanticLabel: '${paper.title} - open paper',
      onHover: (v) => setState(() => _hovered = v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReadingTitleRow(
            title: paper.title,
            hovered: _hovered,
            hasLink: paper.url != null,
          ),
          const SizedBox(height: AppSpacing.xs),
          // Authors · Venue · Year - the citation line.
          Text(
            '${paper.authors}  ·  ${paper.venue} ${paper.year}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: palette.textFaint,
            ),
          ),
          if (paper.summary != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              paper.summary!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: palette.textSecondary,
              ),
            ),
          ],
          if (paper.topics.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [for (final t in paper.topics) TagPill(t)],
            ),
          ],
        ],
      ),
    );
  }
}
