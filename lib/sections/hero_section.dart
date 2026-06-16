import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../widgets/fade_in.dart';
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
    final width = MediaQuery.sizeOf(context).width;

    // Responsive hero name: bold on desktop, never overflowing on a phone.
    final nameSize = Breakpoints.isMobile(width)
        ? 40.0
        : Breakpoints.isTablet(width)
        ? 50.0
        : 58.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // For the arpitbhayani.me-style circular photo, add
        //   import '../widgets/profile_avatar.dart';
        // above, then uncomment these two lines (image lives at
        // assets/images/profile.jpg):
        // const ProfileAvatar(),
        // const SizedBox(height: AppSpacing.xl),

        // The intro fades in as a short sequence (name → tagline → location →
        // prose) so the landing page arrives with a little life rather than
        // all at once. Steps are small and quick to stay calm.
        FadeIn(
          child: Text(
            PortfolioData.name,
            style: AppTypography.heroName(
              palette.textPrimary,
              fontSize: nameSize,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        FadeIn(
          delay: const Duration(milliseconds: 90),
          child: Text(
            PortfolioData.tagline,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: palette.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        FadeIn(
          delay: const Duration(milliseconds: 160),
          child: Row(
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
        ),
        const SizedBox(height: AppSpacing.xl),
        FadeIn(
          delay: const Duration(milliseconds: 240),
          child: ProseText(PortfolioData.intro),
        ),
      ],
    );
  }
}
