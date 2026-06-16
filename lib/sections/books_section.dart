import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../utils/url.dart';
import '../widgets/fade_in.dart';

/// Books - a quiet reading list. Each entry is a title, author and an optional
/// one-line take, separated by hairlines.
class BooksContent extends StatelessWidget {
  const BooksContent({super.key});

  @override
  Widget build(BuildContext context) {
    final books = PortfolioData.books;
    if (books.isEmpty) return const _EmptyState();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Linkable entries float on hover (see _BookEntry) rather than being
        // boxed by dividers, so they're separated by whitespace alone.
        for (var i = 0; i < books.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.xs),
          FadeIn(
            delay: Duration(milliseconds: 60 * (i < 5 ? i : 5)),
            child: _BookEntry(books[i]),
          ),
        ],
      ],
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
          Icon(
            Icons.menu_book_outlined,
            color: palette.textFaint,
            size: 22,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              'My reading list is coming together - the books that shaped '
              'how I build will appear here soon.',
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

class _BookEntry extends StatefulWidget {
  const _BookEntry(this.book);

  final Book book;

  @override
  State<_BookEntry> createState() => _BookEntryState();
}

class _BookEntryState extends State<_BookEntry> {
  bool _hovered = false;
  bool get _hasLink => widget.book.url != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppPalette.of(context);
    final active = _hovered && _hasLink;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: widget.book.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: active ? palette.accent : palette.textPrimary,
                      ),
                    ),
                    TextSpan(
                      text: '  ·  ${widget.book.author}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: palette.textFaint,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_hasLink)
              Icon(
                Icons.north_east,
                size: 16,
                color: active ? palette.accent : palette.textFaint,
              ),
          ],
        ),
        if (widget.book.note != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            widget.book.note!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: palette.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    );

    if (!_hasLink) return content;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => openUrl(widget.book.url!),
        behavior: HitTestBehavior.opaque,
        child: Semantics(link: true, label: widget.book.title, child: content),
      ),
    );
  }
}
