import 'package:flutter/material.dart';

import '../sections/footer_section.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import 'content_container.dart';
import 'fade_in.dart';

/// Shared wrapper for every routed page.
///
/// Owns the page's scroll view (so navigating always starts at the top), gives
/// the content the comfortable reading column and a gentle entrance fade, and
/// appends the shared footer. For inner section pages it also renders a quiet
/// header - a short accent rule, a serif title, and an optional lead line. The
/// Home page passes no [title] since its hero serves as the heading.
class PageScaffold extends StatefulWidget {
  const PageScaffold({
    super.key,
    this.title,
    this.lead,
    required this.child,
    this.topGap = AppSpacing.xxxl,
  });

  /// Page title. When null, no header is rendered (used by Home).
  final String? title;

  /// Optional one-line description under the title.
  final String? lead;

  final Widget child;

  /// Space above the content (below the sticky nav).
  final double topGap;

  @override
  State<PageScaffold> createState() => _PageScaffoldState();
}

class _PageScaffoldState extends State<PageScaffold> {
  // A dedicated, non-primary controller so two pages cross-fading during a
  // route transition never contend for the primary scroll controller.
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppPalette.of(context);

    final body = Padding(
      padding: EdgeInsets.only(top: widget.topGap, bottom: AppSpacing.xxl),
      child: ContentContainer(
        child: FadeIn(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.title != null) ...[
                // Short accent rule - a small editorial kicker.
                Container(
                  width: 28,
                  height: 3,
                  decoration: BoxDecoration(
                    color: palette.accent,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(widget.title!, style: theme.textTheme.displaySmall),
                if (widget.lead != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    widget.lead!,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: palette.textSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.xxl),
              ],
              widget.child,
            ],
          ),
        ),
      ),
    );

    // Keep the body region at least one viewport tall so that on short pages
    // (e.g. the empty Blog page) the footer sits just below the fold instead
    // of floating mid-screen with dead space beneath it. Tall pages simply
    // scroll. (We avoid IntrinsicHeight here: it mis-measures wrapping text /
    // Wrap and would overflow.)
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            primary: false,
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: body,
                ),
                const FooterSection(),
              ],
            ),
          ),
        );
      },
    );
  }
}
