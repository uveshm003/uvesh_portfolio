import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../widgets/prose_text.dart';

/// The Home landing, rendered in the content pane beside the fixed sidebar.
///
/// Leads with a large statement headline, then the prose introduction and a
/// platform matrix of the six targets Uvesh ships to. The full name lives in the
/// sidebar on desktop; on narrow screens it appears here so the page still opens
/// on the name.
class HeroContent extends StatelessWidget {
  const HeroContent({super.key});

  /// A concise, true positioning line distilled from the intro.
  static const String _statement =
      'I build enterprise-grade, offline-first software that ships to six '
      'platforms from a single codebase.';

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = Breakpoints.isDesktop(width);

    final statementSize = Breakpoints.isMobile(width)
        ? 30.0
        : Breakpoints.isTablet(width)
        ? 38.0
        : 46.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // On narrow screens the sidebar is collapsed, so surface the name here.
        if (!isDesktop) ...[
          Text(
            PortfolioData.name,
            style: AppTypography.heroName(palette.textPrimary, fontSize: 40),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],

        Text(
          'INTRODUCTION',
          style: AppTypography.sectionLabel(palette.accent),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          _statement,
          style: AppTypography.heroName(
            palette.textPrimary,
            fontSize: statementSize,
          ).copyWith(height: 1.08, letterSpacing: -0.8),
        ),
        const SizedBox(height: AppSpacing.xl),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: ProseText(PortfolioData.intro),
        ),
        const SizedBox(height: AppSpacing.xl),
        const _PlatformMatrix(),
      ],
    );
  }
}

/// The six Flutter targets Uvesh ships to, drawn as a small status matrix.
class _PlatformMatrix extends StatelessWidget {
  const _PlatformMatrix();

  static const List<String> _targets = [
    'ANDROID',
    'iOS',
    'WINDOWS',
    'macOS',
    'LINUX',
    'WEB',
  ];

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('SHIPS TO', style: AppTypography.sectionLabel(palette.textFaint)),
            const SizedBox(width: AppSpacing.sm),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [for (final t in _targets) _PlatformCell(t)],
        ),
      ],
    );
  }
}

class _PlatformCell extends StatelessWidget {
  const _PlatformCell(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: palette.divider),
        color: palette.surface.withValues(alpha: 0.5),
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
            label,
            style: AppTypography.mono(
              palette.textSecondary,
              fontSize: 11.5,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
