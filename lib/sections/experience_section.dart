import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../widgets/hover_link.dart';

/// Experience — a quiet vertical timeline. A hairline rail runs down the left
/// with a small node beside each role; the entries themselves stay prose-first
/// (role · company · dates, then a short blurb). The rail gives the page a
/// gentle spine without turning entries into boxed cards.
class ExperienceContent extends StatelessWidget {
  const ExperienceContent({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = PortfolioData.experiences;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < entries.length; i++)
          _TimelineEntry(
            entry: entries[i],
            isLast: i == entries.length - 1,
          ),
      ],
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({required this.entry, required this.isLast});

  final Experience entry;
  final bool isLast;

  static const double _railWidth = 34;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // The rail: a node aligned with the role line, and a hairline that
          // continues down through the spacing into the next entry.
          SizedBox(
            width: _railWidth,
            child: Column(
              children: [
                // Nudge the node down so it lines up with the role text.
                const SizedBox(height: 7),
                _Node(color: palette.accent, ring: palette.divider),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.5,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: palette.divider,
                    ),
                  ),
              ],
            ),
          ),
          // Content. Bottom padding (except the last) sets the vertical rhythm
          // and the rail's hairline runs through it.
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.xxl),
              child: _EntryBody(entry),
            ),
          ),
        ],
      ),
    );
  }
}

class _Node extends StatelessWidget {
  const _Node({required this.color, required this.ring});

  final Color color;
  final Color ring;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: ring, width: 2.5),
      ),
    );
  }
}

class _EntryBody extends StatelessWidget {
  const _EntryBody(this.entry);

  final Experience entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = AppPalette.of(context);

    final roleStyle = AppTypography.heroName(palette.textPrimary, fontSize: 21);
    final company = entry.url == null
        ? Text(
            entry.company,
            style: roleStyle.copyWith(color: palette.accent),
          )
        : HoverLink(
            label: entry.company,
            url: entry.url,
            baseColor: palette.accent,
            style: roleStyle.copyWith(color: palette.accent),
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Role · Company on one line; wraps gracefully on narrow screens.
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(entry.role, style: roleStyle),
            Text('  ·  ', style: roleStyle.copyWith(color: palette.textFaint)),
            company,
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          '${entry.period}  ·  ${entry.location}',
          style: AppTypography.mono(palette.textFaint, fontSize: 12.5),
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
