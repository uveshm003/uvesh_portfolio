import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import '../theme/theme_controller.dart';
import 'sidebar.dart';

/// Persistent chrome shared by every page.
///
/// On desktop a fixed identity [Sidebar] sits on the left while the routed page
/// (supplied via go_router's ShellRoute) owns its own scroll in the content
/// pane on the right. On narrow screens the sidebar collapses to a [MobileBar]
/// pinned to the top, with the content below.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child, required this.controller});

  final Widget child;
  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWide = Breakpoints.isDesktop(MediaQuery.sizeOf(context).width);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: isWide
          ? Row(
              children: [
                Sidebar(controller: controller),
                Expanded(child: child),
              ],
            )
          : Column(
              children: [
                MobileBar(controller: controller),
                Expanded(child: child),
              ],
            ),
    );
  }
}
