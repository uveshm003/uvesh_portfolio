import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../widgets/fade_in.dart';

/// Education - two quiet list entries (degree · institution · dates · score).
class EducationContent extends StatelessWidget {
  const EducationContent({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < PortfolioData.education.length; i++) ...[
          // Same hairline rhythm as Experience so the two read as one family.
          if (i > 0) ...[
            const SizedBox(height: AppSpacing.lg),
            Divider(color: palette.divider, height: 1),
            const SizedBox(height: AppSpacing.lg),
          ],
          FadeIn(
            delay: Duration(milliseconds: 60 * (i < 5 ? i : 5)),
            child: _EducationEntry(PortfolioData.education[i]),
          ),
        ],
      ],
    );
  }
}

class _EducationEntry extends StatelessWidget {
  const _EducationEntry(this.item);

  final EducationItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppPalette.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.degree, style: theme.textTheme.titleMedium),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          item.institution,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: palette.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          '${item.period}  ·  ${item.score}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: palette.textFaint,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}
