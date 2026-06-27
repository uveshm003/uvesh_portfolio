import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';

/// The section eyebrow used across the site (e.g. "Featured Work", "Education",
/// page headers). A small accent pill — a status dot plus a tracked small-caps
/// label — rather than a bare dash-and-text marker. Reusing one chip everywhere
/// keeps the language consistent and gets rid of the scattered little rules.
class MiniHeading extends StatelessWidget {
  const MiniHeading(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return Semantics(
      header: true,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 12, 6),
        decoration: BoxDecoration(
          color: palette.accentSoft,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: palette.accent.withValues(alpha: 0.22)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: palette.accent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label.toUpperCase(),
              style: AppTypography.sectionLabel(palette.accent).copyWith(
                fontSize: 11,
                letterSpacing: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
