import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

/// Centers its child within the comfortable reading measure and applies the
/// responsive horizontal gutter. Every section sits inside one of these so the
/// whole page shares a single column width.
class ContentContainer extends StatelessWidget {
  const ContentContainer({super.key, required this.child, this.maxWidth});

  final Widget child;

  /// Override the default reading-measure cap (e.g. the hero is a touch wider).
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final gutter = Breakpoints.isMobile(width)
        ? AppSpacing.gutterMobile
        : AppSpacing.gutterWide;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: gutter),
      // Top-aligned, not centered: on short pages the scaffold stretches this
      // region to a full viewport, and a plain Center would float the content
      // halfway down. We only want the horizontal centering of the column.
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? AppSpacing.contentMaxWidth,
          ),
          child: child,
        ),
      ),
    );
  }
}
