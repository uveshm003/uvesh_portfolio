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
    return Scaffold(
      body: Column(
        children: [
          TopNav(controller: controller),
          Expanded(child: child),
        ],
      ),
    );
  }
}
