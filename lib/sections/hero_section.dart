import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../widgets/prose_text.dart';

/// The hero / intro shown on the Home page: (optional circular photo,) name,
/// tagline, location and the flowing prose introduction with inline links.
/// Left-aligned and prose-forward - no cards, no boxes.
class HeroContent extends StatelessWidget {
  const HeroContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppPalette.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // For the arpitbhayani.me-style circular photo, add
        //   import '../widgets/profile_avatar.dart';
        // above, then uncomment these two lines (image lives at
        // assets/images/profile.jpg):
        // const ProfileAvatar(),
        // const SizedBox(height: AppSpacing.xl),
        Text(PortfolioData.name, style: theme.textTheme.displaySmall),
        const SizedBox(height: AppSpacing.sm),
        Text(
          PortfolioData.tagline,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: palette.textSecondary,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.place_outlined, size: 15, color: palette.textFaint),
            const SizedBox(width: AppSpacing.xxs),
            Text(
              PortfolioData.location,
              style: theme.textTheme.bodySmall?.copyWith(
                color: palette.textFaint,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        ProseText(PortfolioData.intro),
      ],
    );
  }
}
