import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';

/// A small, quiet sub-heading used inside a page (e.g. "Education" on Home):
/// a short accent rule followed by an uppercase label.
class MiniHeading extends StatelessWidget {
  const MiniHeading(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return Semantics(
      header: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 22,
            height: 2,
            margin: const EdgeInsets.only(right: AppSpacing.sm),
            decoration: BoxDecoration(
              color: palette.accent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Text(
            label.toUpperCase(),
            style: AppTypography.sectionLabel(palette.textFaint),
          ),
        ],
      ),
    );
  }
}
