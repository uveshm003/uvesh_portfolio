import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';

/// Skills - grouped and scannable. Each group is a quiet label with inline,
/// tag-style items. Deliberately light: thin-bordered pills, no loud badges.
class SkillsContent extends StatelessWidget {
  const SkillsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < PortfolioData.skills.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.lg),
          _SkillGroupRow(PortfolioData.skills[i]),
        ],
      ],
    );
  }
}

class _SkillGroupRow extends StatelessWidget {
  const _SkillGroupRow(this.group);

  final SkillGroup group;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // A tiny accent tick + uppercase label ties the group headers to the
        // editorial kickers used elsewhere on the site.
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 14,
              height: 2,
              margin: const EdgeInsets.only(right: AppSpacing.xs),
              decoration: BoxDecoration(
                color: palette.accent.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              group.label.toUpperCase(),
              style: AppTypography.sectionLabel(
                palette.textFaint,
              ).copyWith(fontSize: 11.5, letterSpacing: 1.3),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
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

class _SkillTag extends StatefulWidget {
  const _SkillTag(this.label);

  final String label;

  @override
  State<_SkillTag> createState() => _SkillTagState();
}

class _SkillTagState extends State<_SkillTag> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs - 1,
        ),
        decoration: BoxDecoration(
          color: _hovered ? palette.accentSoft : palette.surface,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: _hovered
                ? palette.accent.withValues(alpha: 0.45)
                : palette.divider,
          ),
        ),
        child: Text(
          widget.label,
          style: AppTypography.tag(
            _hovered ? palette.accent : palette.textSecondary,
          ),
        ),
      ),
    );
  }
}
