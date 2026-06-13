import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';
import 'content_container.dart';
import 'fade_in.dart';

/// A page section: a small, quiet label followed by its content, wrapped in the
/// shared reading column and given consistent vertical rhythm. The [anchorKey]
/// lets the nav scroll this section into view.
class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.label,
    required this.child,
    this.anchorKey,
  });

  final String label;
  final Widget child;
  final GlobalKey? anchorKey;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);

    return Padding(
      key: anchorKey,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl / 1.5),
      child: ContentContainer(
        child: FadeIn(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quiet uppercase section label, prefixed with a short accent
              // rule — a small editorial touch that keeps the chrome calm.
              Semantics(
                header: true,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 22,
                      height: 2,
                      margin: const EdgeInsets.only(right: AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: palette.accent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Text(
                      label.toUpperCase(),
                      style: AppTypography.sectionLabel(palette.textFaint),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
