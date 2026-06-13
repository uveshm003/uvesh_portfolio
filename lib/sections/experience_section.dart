import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../widgets/hover_link.dart';

/// Experience - list-style entries (role · company · dates) each with a short
/// prose blurb. Quiet, not boxed-in: entries are separated by whitespace and a
/// hairline rather than cards.
class ExperienceContent extends StatelessWidget {
  const ExperienceContent({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < PortfolioData.experiences.length; i++) ...[
          if (i > 0) ...[
            const SizedBox(height: AppSpacing.xl),
            Divider(color: palette.divider, height: 1),
            const SizedBox(height: AppSpacing.xl),
          ],
          _ExperienceEntry(PortfolioData.experiences[i]),
        ],
      ],
    );
  }
}

class _ExperienceEntry extends StatelessWidget {
  const _ExperienceEntry(this.entry);

  final Experience entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppPalette.of(context);

    final company = entry.url == null
        ? Text(
            entry.company,
            style: theme.textTheme.titleMedium?.copyWith(
              color: palette.accent,
            ),
          )
        : HoverLink(
            label: entry.company,
            url: entry.url,
            baseColor: palette.accent,
            style: theme.textTheme.titleMedium,
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Role · Company on one line; wraps gracefully on narrow screens.
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(entry.role, style: theme.textTheme.titleMedium),
            Text(
              '  ·  ',
              style: theme.textTheme.titleMedium?.copyWith(
                color: palette.textFaint,
              ),
            ),
            company,
          ],
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          '${entry.period}  ·  ${entry.location}',
          style: theme.textTheme.bodySmall?.copyWith(color: palette.textFaint),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          entry.blurb,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: palette.textSecondary,
          ),
        ),
      ],
    );
  }
}
