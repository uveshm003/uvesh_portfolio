import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../widgets/content_container.dart';
import '../widgets/hover_link.dart';

/// Footer — grouped links (Contact / Social / Built with) and a copyright line.
/// Separated from the page body by a hairline and a little breathing room.
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppPalette.of(context);

    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.xxl),
      padding: const EdgeInsets.only(
        top: AppSpacing.xxl,
        bottom: AppSpacing.xxxl,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: palette.divider)),
      ),
      child: ContentContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: AppSpacing.huge / 2,
              runSpacing: AppSpacing.xl,
              children: [
                _FooterGroup(title: 'Contact', links: PortfolioData.contactLinks),
                _FooterGroup(title: 'Social', links: PortfolioData.socialLinks),
                const _BuiltWithGroup(),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text(
              '© 2025 ${PortfolioData.name}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: palette.textFaint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterGroup extends StatelessWidget {
  const _FooterGroup({required this.title, required this.links});

  final String title;
  final List<LinkRef> links;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: AppTypography.sectionLabel(palette.textFaint),
        ),
        const SizedBox(height: AppSpacing.md),
        for (final link in links) ...[
          HoverLink(
            label: link.label,
            url: link.url,
            baseColor: palette.textSecondary,
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

/// "Built with" credits — these are informational links, not personal contacts.
class _BuiltWithGroup extends StatelessWidget {
  const _BuiltWithGroup();

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BUILT WITH',
          style: AppTypography.sectionLabel(palette.textFaint),
        ),
        const SizedBox(height: AppSpacing.md),
        HoverLink(
          label: 'Flutter',
          url: 'https://flutter.dev',
          baseColor: palette.textSecondary,
        ),
        const SizedBox(height: AppSpacing.sm),
        HoverLink(
          label: 'Source on GitHub',
          url: PortfolioData.githubUrl,
          baseColor: palette.textSecondary,
        ),
      ],
    );
  }
}
