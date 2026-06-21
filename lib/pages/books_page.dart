import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../sections/books_section.dart';
import '../theme/app_spacing.dart';
import '../widgets/fade_in.dart';
import '../widgets/mini_heading.dart';
import '../widgets/page_scaffold.dart';

/// Reading - what's on the desk right now and the books that shaped how I
/// build. Each is an in-page section under its own [MiniHeading]. Research
/// papers live on their own page.
class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Currently Reading is optional - drop the whole block when the list is
    // empty so the page opens straight onto the shelf.
    final hasCurrent = PortfolioData.currentlyReading.isNotEmpty;

    return PageScaffold(
      title: 'Reading',
      lead: "What's on the desk right now, and the books that shaped how I "
          'build.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasCurrent) ...const [
            FadeIn(child: MiniHeading('Currently Reading')),
            SizedBox(height: AppSpacing.lg),
            FadeIn(delay: Duration(milliseconds: 80), child: CurrentlyReadingContent()),
            SizedBox(height: AppSpacing.xxl),
          ],
          const FadeIn(child: MiniHeading('Bookshelf')),
          const SizedBox(height: AppSpacing.lg),
          const FadeIn(delay: Duration(milliseconds: 80), child: BooksContent()),
        ],
      ),
    );
  }
}
