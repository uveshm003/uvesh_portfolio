import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import '../utils/url.dart';
import '../widgets/mini_heading.dart';
import '../widgets/prose_text.dart';

/// The Home landing, rendered in the content pane beside the fixed sidebar.
///
/// Reads top-to-bottom the way a hiring manager scans: a scannable headline,
/// a strip of verifiable proof numbers, the calls to action, then the prose
/// introduction and the platform matrix of the six targets Uvesh ships to. The
/// full name lives in the sidebar on desktop; on narrow screens it appears here
/// so the page still opens on the name.
class HeroContent extends StatelessWidget {
  const HeroContent({super.key});

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
          const SizedBox(height: AppSpacing.xs),
          Text(
            PortfolioData.tagline.toUpperCase(),
            style: AppTypography.sectionLabel(palette.accent),
          ),
          const SizedBox(height: AppSpacing.xl),
        ] else ...[
          const MiniHeading('Introduction'),
          const SizedBox(height: AppSpacing.md),
        ],

        // The headline — a confident, scannable positioning line with the
        // signature claim ("six platforms") lifted into the accent.
        _Headline(fontSize: statementSize),
        const SizedBox(height: AppSpacing.xl),

        // Verifiable proof, the first thing a recruiter should be able to scan.
        const _ProofStrip(),
        const SizedBox(height: AppSpacing.xl),

        // Calls to action.
        const _HeroActions(),
        const SizedBox(height: AppSpacing.xxl),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ProseText(PortfolioData.intro),
        ),
        const SizedBox(height: AppSpacing.xl),
        const _PlatformMatrix(),
      ],
    );
  }
}

/// The two-tone hero headline. Most of the line is primary ink; the load-bearing
/// phrase "six platforms" runs in the accent so the eye lands on the claim.
class _Headline extends StatelessWidget {
  const _Headline({required this.fontSize});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final base = AppTypography.heroName(
      palette.textPrimary,
      fontSize: fontSize,
    ).copyWith(height: 1.08, letterSpacing: -0.8);

    return Text.rich(
      TextSpan(
        style: base,
        children: [
          const TextSpan(
            text: 'I build enterprise-grade, offline-first products that '
                'ship to ',
          ),
          TextSpan(text: 'six platforms', style: TextStyle(color: palette.accent)),
          const TextSpan(text: ' from a single codebase.'),
        ],
      ),
    );
  }
}

/// A horizontal strip of proof numbers (years, platforms, apps, roles). Each
/// cell is a loud display numeral over a quiet mono caption, separated by thin
/// rules so it reads like a calibrated readout rather than marketing.
class _ProofStrip extends StatelessWidget {
  const _ProofStrip();

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final stats = PortfolioData.heroStats;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: palette.divider),
          bottom: BorderSide(color: palette.divider),
        ),
      ),
      child: Wrap(
        children: [
          for (var i = 0; i < stats.length; i++)
            IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _StatCell(stat: stats[i]),
                  if (i < stats.length - 1)
                    VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: palette.divider,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({required this.stat});

  final HeroStat stat;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, AppSpacing.md, AppSpacing.xl, AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            stat.value,
            style: AppTypography.heroName(palette.textPrimary, fontSize: 32)
                .copyWith(letterSpacing: -1.0),
          ),
          const SizedBox(height: 2),
          Text(
            stat.label,
            style: AppTypography.sectionLabel(palette.textFaint).copyWith(
              fontSize: 10.5,
              letterSpacing: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

/// The hero call-to-action row: a primary filled GitHub button followed by
/// outlined LinkedIn / Email actions.
class _HeroActions extends StatelessWidget {
  const _HeroActions();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        _CtaButton(
          label: 'GitHub',
          icon: Icons.code_rounded,
          url: PortfolioData.githubUrl,
          primary: true,
        ),
        _CtaButton(
          label: 'LinkedIn',
          icon: Icons.person_outline_rounded,
          url: PortfolioData.linkedInUrl,
        ),
        _CtaButton(
          label: 'Email',
          icon: Icons.mail_outline_rounded,
          url: PortfolioData.emailUrl,
        ),
      ],
    );
  }
}

class _CtaButton extends StatefulWidget {
  const _CtaButton({
    required this.label,
    required this.icon,
    required this.url,
    this.primary = false,
  });

  final String label;
  final IconData icon;
  final String url;
  final bool primary;

  @override
  State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final primary = widget.primary;

    final Color fg;
    final Color bg;
    final Color border;
    if (primary) {
      bg = _hovered ? palette.accentHover : palette.accent;
      fg = Colors.white;
      border = bg;
    } else {
      bg = _hovered ? palette.accentSoft : Colors.transparent;
      fg = _hovered ? palette.accent : palette.textPrimary;
      border = _hovered ? palette.accent : palette.divider;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => openUrl(widget.url),
        behavior: HitTestBehavior.opaque,
        child: Semantics(
          link: true,
          label: widget.label,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: bg,
              border: Border.all(color: border),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.icon, size: 16, color: fg),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  widget.label,
                  style: AppTypography.mono(
                    fg,
                    fontSize: 13,
                    weight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
        borderRadius: BorderRadius.circular(4),
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
