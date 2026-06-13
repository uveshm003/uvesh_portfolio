import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';

/// Circular profile photo. Loads [PortfolioData.profileImage] from assets and,
/// if that fails (e.g. before the user drops in their own photo), falls back to
/// the person's initials so the layout never breaks.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, this.size = AppSpacing.avatarSize});

  final double size;

  String get _initials {
    final parts = PortfolioData.name.trim().split(RegExp(r'\s+'));
    if (parts.length < 2) return parts.first.characters.first;
    return '${parts.first.characters.first}${parts.last.characters.first}';
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);

    return Semantics(
      image: true,
      label: 'Portrait of ${PortfolioData.name}',
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: palette.divider, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.asset(
          PortfolioData.profileImage,
          width: size,
          height: size,
          fit: BoxFit.cover,
          // Cache at display resolution to keep the bundle light on screen.
          cacheWidth: (size * 3).round(),
          errorBuilder: (context, error, stack) => _InitialsFallback(
            initials: _initials,
            size: size,
          ),
        ),
      ),
    );
  }
}

class _InitialsFallback extends StatelessWidget {
  const _InitialsFallback({required this.initials, required this.size});

  final String initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    return Container(
      width: size,
      height: size,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      alignment: Alignment.center,
      child: Text(
        initials.toUpperCase(),
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: palette.textSecondary,
        ),
      ),
    );
  }
}
