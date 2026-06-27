import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import '../theme/theme_controller.dart';
import 'sidebar.dart';

/// Persistent chrome shared by every page.
///
/// On desktop a fixed identity [Sidebar] sits on the left while the routed page
/// (supplied via go_router's ShellRoute) owns its own scroll in the content
/// pane on the right. On narrow screens the sidebar collapses to a [MobileBar]
/// pinned to the top, with a slide-in [NavDrawer] for navigation.
class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.child, required this.controller});

  final Widget child;
  final ThemeController controller;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  // A stable key so the mobile bar's menu button can open the end drawer
  // directly, without relying on Scaffold.of() lookups.
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWide = Breakpoints.isDesktop(MediaQuery.sizeOf(context).width);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: theme.scaffoldBackgroundColor,
      // The slide-in navigation lives on the right on narrow screens; desktop
      // uses the persistent left sidebar instead.
      endDrawer: isWide ? null : NavDrawer(controller: widget.controller),
      body: isWide
          ? Row(
              children: [
                Sidebar(controller: widget.controller),
                Expanded(child: widget.child),
              ],
            )
          : Column(
              children: [
                MobileBar(
                  controller: widget.controller,
                  onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
                ),
                Expanded(child: widget.child),
              ],
            ),
    );
  }
}
