import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';

/// Education - two quiet list entries (degree · institution · dates · score).
class EducationContent extends StatelessWidget {
  const EducationContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < PortfolioData.education.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.lg),
          _EducationEntry(PortfolioData.education[i]),
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
          style: theme.textTheme.bodySmall?.copyWith(color: palette.textFaint),
        ),
      ],
    );
  }
}
