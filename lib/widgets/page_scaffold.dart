import 'package:flutter/material.dart';

import '../sections/footer_section.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import 'fade_in.dart';

/// Shared wrapper for every routed page, rendered inside the content pane to the
/// right of the fixed sidebar (or below the mobile bar).
///
/// Owns the pane's scroll view (so navigating always starts at the top),
/// left-aligns the content within a comfortable measure, gives a gentle
/// entrance fade, and appends the shared footer. For inner section pages it
/// renders a quiet header: a mono eyebrow, a large title, and an optional lead.
class PageScaffold extends StatefulWidget {
  const PageScaffold({
    super.key,
    this.title,
    this.eyebrow,
    this.lead,
    required this.child,
    this.topGap = AppSpacing.xxl,
    this.maxWidth,
  });

  /// Page title. When null, no header is rendered (used by Home).
  final String? title;

  /// Optional monospace eyebrow shown above the title (e.g. "WORK HISTORY").
  final String? eyebrow;

  /// Optional one-line description under the title.
  final String? lead;

  final Widget child;

  /// Space above the content (below the bar / at the pane top).
  final double topGap;

  /// Optional override for the content column width.
  final double? maxWidth;

  @override
  State<PageScaffold> createState() => _PageScaffoldState();
}

class _PageScaffoldState extends State<PageScaffold> {
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
    final width = MediaQuery.sizeOf(context).width;
    final isWide = Breakpoints.isDesktop(width);

    final gutter = isWide ? AppSpacing.paneGutter : AppSpacing.gutterMobile;
    final measure = widget.maxWidth ?? AppSpacing.paneMaxWidth;

    // Wraps any pane child in the shared gutters + left-aligned measure.
    Widget pane(Widget child, {EdgeInsets? padding}) => Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: gutter),
      child: Align(
        alignment: Alignment.topLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: measure),
          child: child,
        ),
      ),
    );

    final header = widget.title == null
        ? null
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 22, height: 2, color: palette.accent),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    (widget.eyebrow ?? widget.title!).toUpperCase(),
                    style: AppTypography.sectionLabel(palette.accent),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(widget.title!, style: theme.textTheme.displaySmall),
              if (widget.lead != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(
                  widget.lead!,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: palette.textSecondary,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.xxl),
            ],
          );

    final body = Padding(
      padding: EdgeInsets.only(
        top: widget.topGap,
        bottom: AppSpacing.xxl,
      ),
      child: FadeIn(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ?header,
            widget.child,
          ],
        ),
      ),
    );

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
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: pane(body),
                ),
                FooterSection(gutter: gutter, measure: measure),
              ],
            ),
          ),
        );
      },
    );
  }
}
