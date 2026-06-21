import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../widgets/category_filter.dart';
import '../widgets/fade_in.dart';
import 'reading_widgets.dart';

/// Currently reading - the books on the desk right now, each as a card with a
/// thin progress bar. Hidden by the page when the list is empty.
class CurrentlyReadingContent extends StatelessWidget {
  const CurrentlyReadingContent({super.key});

  @override
  Widget build(BuildContext context) {
    final books = PortfolioData.currentlyReading;
    if (books.isEmpty) {
      return const ReadingEmptyState(
        icon: Icons.auto_stories_outlined,
        message: "Nothing on the desk right now - I'll surface what I'm "
            'reading here as soon as I crack the next spine.',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < books.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.sm),
          FadeIn(
            delay: Duration(milliseconds: 60 * (i < 5 ? i : 5)),
            child: _CurrentlyReadingCard(books[i]),
          ),
        ],
      ],
    );
  }
}

class _CurrentlyReadingCard extends StatefulWidget {
  const _CurrentlyReadingCard(this.book);

  final Book book;

  @override
  State<_CurrentlyReadingCard> createState() => _CurrentlyReadingCardState();
}

class _CurrentlyReadingCardState extends State<_CurrentlyReadingCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppPalette.of(context);
    final book = widget.book;
    final progress = (book.progress ?? 0).clamp(0.0, 1.0);

    return ReadingCard(
      url: book.url,
      semanticLabel: book.title,
      onHover: (v) => setState(() => _hovered = v),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // A small "spine" mark that nods to a book on a shelf.
          Container(
            width: 4,
            height: 38,
            margin: const EdgeInsets.only(top: 2, right: AppSpacing.md),
            decoration: BoxDecoration(
              color: palette.accent.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReadingTitleRow(
                  title: book.title,
                  hovered: _hovered,
                  hasLink: book.url != null,
                  trailing: book.tag != null ? TagPill(book.tag!) : null,
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  book.author,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: palette.textFaint,
                  ),
                ),
                if (book.note != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    book.note!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: palette.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.md),
                _ProgressBar(value: progress),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A thin accent progress bar with a trailing percentage.
class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppPalette.of(context);

    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Stack(
              children: [
                Container(height: 5, color: palette.divider),
                FractionallySizedBox(
                  widthFactor: value,
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                      color: palette.accent,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          '${(value * 100).round()}%',
          style: theme.textTheme.bodySmall?.copyWith(
            color: palette.textFaint,
          ),
        ),
      ],
    );
  }
}

/// Bookshelf - finished / recommended reads, filtered by category, each a
/// compact card that lifts on hover when it links out.
class BooksContent extends StatelessWidget {
  const BooksContent({super.key});

  @override
  Widget build(BuildContext context) {
    final books = PortfolioData.books;
    if (books.isEmpty) {
      return const ReadingEmptyState(
        icon: Icons.menu_book_outlined,
        message: 'My reading list is coming together - the books that shaped '
            'how I build will appear here soon.',
      );
    }

    return CategoryFilteredList<Book>(
      items: books,
      categoryOf: (b) => b.category,
      emptyMessage: const ReadingEmptyState(
        icon: Icons.menu_book_outlined,
        message: 'No books in this category yet - try another.',
      ),
      builder: (context, list) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < list.length; i++) ...[
            if (i > 0) const SizedBox(height: AppSpacing.sm),
            FadeIn(
              delay: Duration(milliseconds: 60 * (i < 5 ? i : 5)),
              child: _BookCard(list[i]),
            ),
          ],
        ],
      ),
    );
  }
}

class _BookCard extends StatefulWidget {
  const _BookCard(this.book);

  final Book book;

  @override
  State<_BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<_BookCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppPalette.of(context);
    final book = widget.book;

    return ReadingCard(
      url: book.url,
      semanticLabel: book.title,
      onHover: (v) => setState(() => _hovered = v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReadingTitleRow(
            title: book.title,
            hovered: _hovered,
            hasLink: book.url != null,
            trailing: book.tag != null ? TagPill(book.tag!) : null,
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            book.author,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: palette.textFaint,
            ),
          ),
          if (book.note != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              book.note!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: palette.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
