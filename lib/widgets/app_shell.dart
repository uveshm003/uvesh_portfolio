import 'package:flutter/material.dart';

import '../theme/theme_controller.dart';
import 'top_nav.dart';

/// Persistent chrome shared by every page: the sticky top nav above the routed
/// content. The routed page (supplied via [child] by go_router's ShellRoute)
/// owns its own scroll view and footer, so it is bounded here by [Expanded]
/// rather than nested inside a scroll view.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child, required this.controller});

  final Widget child;
  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // A barely-there wash behind everything so the page reads as a soft surface
    // rather than one flat fill. The glow sits up top and fades to the plain
    // background; it's derived from theme tokens so it tracks light/dark and
    // introduces no new hue.
    final background = theme.scaffoldBackgroundColor;
    final wash = Color.lerp(
      background,
      theme.colorScheme.surfaceContainerHighest,
      0.35,
    )!;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0, -1.1),
          radius: 1.5,
          colors: [wash, background],
          stops: const [0.0, 0.65],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // The routed page fills the area and owns its scroll; the frosted nav
        // floats on top so content blurs softly through it as you scroll.
        // (Pages reserve space for the bar via PageScaffold's top padding.)
        body: Stack(
          children: [
            Positioned.fill(child: child),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: TopNav(controller: controller),
            ),
          ],
        ),
      ),
    );
  }
}
