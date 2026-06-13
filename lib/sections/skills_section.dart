import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../widgets/section.dart';

/// Skills — grouped and scannable. Each group is a quiet label with inline,
/// tag-style items. Deliberately light: thin-bordered pills, no loud badges.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key, this.anchorKey});

  final GlobalKey? anchorKey;

  @override
  Widget build(BuildContext context) {
    return Section(
      label: 'Skills',
      anchorKey: anchorKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < PortfolioData.skills.length; i++) ...[
            if (i > 0) const SizedBox(height: AppSpacing.lg),
            _SkillGroupRow(PortfolioData.skills[i]),
          ],
        ],
      ),
    );
  }
}

class _SkillGroupRow extends StatelessWidget {
  const _SkillGroupRow(this.group);

  final SkillGroup group;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppPalette.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          group.label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: palette.textFaint,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            for (final item in group.items) _SkillTag(item),
          ],
        ),
      ],
    );
  }
}

class _SkillTag extends StatelessWidget {
  const _SkillTag(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs - 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: palette.divider),
      ),
      child: Text(label, style: AppTypography.tag(palette.textSecondary)),
    );
  }
}
